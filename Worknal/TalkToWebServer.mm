//
//  TalkToWebServerViewController.mm
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//
#import "TalkToWebServerViewController.h"
#import "MBProgressHUD.h"

@interface TalkToWebServerViewController ()
@end

@implementation TalkToWebServerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) createUserIfDoesntExistWithEmail:(NSString *)email {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/bulletinREST/createUser.php"];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *params = [NSString stringWithFormat:@"email_address=%@", email];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                           
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                                                   
                                                                   NSLog(@"Error 400");
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSError *jsonError;
                                                                   
                                                                   NSLog(@"==========");
                                                                   NSLog(@"%@",data);
                                                                   NSLog(@"==========");
                                                                   
                                                                   NSDictionary *json =
                                                                   [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions // NSJSONReadingAllowFragments
                                                                                                     error:&jsonError];
                                                                   
                                                                   NSInteger count = [[json allKeys] count];
                                                                   
                                                                   NSLog(@"count = %ld", (long)count);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserCreatedIfDidntExist" object:self userInfo:json];
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];

    
}

- (void) createCompanyIfDoesntExistWithDomain:(NSString *)domain {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/bulletinREST/createCompany.php"];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *params = [NSString stringWithFormat:@"company_domain=%@", domain];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                           
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                                                   
                                                                   NSLog(@"Error 400");
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSError *jsonError;
                                                                   
                                                                   NSLog(@"==========");
                                                                   NSLog(@"%@",data);
                                                                   NSLog(@"==========");
                                                                   
                                                                   NSDictionary *json =
                                                                   [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions // NSJSONReadingAllowFragments
                                                                                                     error:&jsonError];
                                                                   
                                                                   NSInteger count = [[json allKeys] count];
                                                                   
                                                                   NSLog(@"count = %ld", (long)count);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kCompanyCreatedIfDidntExist" object:self userInfo:json];
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];
    
    
}


- (void) requestUsersFeedbackForUUID:(NSString *)uuid {
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueIdentifier = [[device identifierForVendor] UUIDString];
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Gathering your feeedback...";
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/ratingREST/1/ratings/users/%@/", uuid];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"rw_app_id=1&code=%@&device_id%@", @"a code", uniqueIdentifier];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           //[MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                            
                                                                   NSLog(@"Error 400");
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSError *jsonError;
                                                                   
                                                                   NSLog(@"==========");
                                                                   NSLog(@"%@",data);
                                                                   NSLog(@"==========");
                                                                   
                                                                   NSDictionary *json =
                                                                   [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions // NSJSONReadingAllowFragments
                                                                                                     error:&jsonError];
                                                                   
                                                                   NSInteger count = [[json allKeys] count];
                                                                   
                                                                   NSLog(@"count = %ld", (long)count);
                                                                   
                                                                   /*
                                                                   NSString *rating_one = [json objectForKey:@"rating_one"];
                                                                   NSString *rating_two = [json objectForKey:@"rating_two"];
                                                                   NSString *rating_three = [json objectForKey:@"rating_three"];
                                                                   NSString *rating_four = [json objectForKey:@"rating_four"];
                                                                   NSString *rating_five = [json objectForKey:@"rating_five"];
                                                                   NSString *rating_six = [json objectForKey:@"rating_six"];
                                                                   NSString *rating_seven = [json objectForKey:@"rating_seven"];
                                                                   NSString *rating_eight = [json objectForKey:@"rating_eight"];
                                                                   NSString *rating_nine = [json objectForKey:@"rating_nine"];
                                                                   NSString *rating_ten = [json objectForKey:@"rating_ten"];

                                                                   NSLog(@"rating_one = %@", rating_one);
                                                                   NSLog(@"rating_two = %@", rating_two);
                                                                   NSLog(@"rating_three = %@", rating_three);
                                                                   NSLog(@"rating_four = %@", rating_four);
                                                                   NSLog(@"rating_five = %@", rating_five);
                                                                   NSLog(@"rating_six = %@", rating_six);
                                                                   NSLog(@"rating_seven = %@", rating_seven);
                                                                   NSLog(@"rating_eight = %@", rating_eight);
                                                                   NSLog(@"rating_nine = %@", rating_nine);
                                                                   NSLog(@"rating_ten = %@", rating_ten);
                                                                    */
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kUsersFeedback" object:self userInfo:json];
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];
    
}

- (void) requestUsersFeedbackForPersonID:(NSString *)personID {
 
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/ratingREST/getAvailableFeedback.php"];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"person_id=%@", personID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                           
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                                                   
                                                                   NSLog(@"Error 400");
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableFeedback" object:self userInfo:nil];
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableFeedback" object:self userInfo:nil];
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSError *jsonError;
                                                                   
                                                                   NSLog(@"==========");
                                                                   NSLog(@"%@",data);
                                                                   NSLog(@"==========");
                                                                   
                                                                   NSDictionary *json =
                                                                   [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions // NSJSONReadingAllowFragments
                                                                                                     error:&jsonError];
                                                                   
                                                                   NSInteger count = [[json allKeys] count];
                                                                   
                                                                   NSLog(@"count = %ld", (long)count);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableFeedback" object:self userInfo:json];
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableFeedback" object:self userInfo:nil];
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];
    
}

- (void) requestBulletinsForCompanyID:(NSString *)companyID {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/bulletinREST/getAvailableBulletins.php"];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"company_id=%@", companyID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                           
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                                                   
                                                                   NSLog(@"Error 400");
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletins" object:self userInfo:nil];
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletins" object:self userInfo:nil];
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSError *jsonError;
                                                                   
                                                                   NSLog(@"==========");
                                                                   NSLog(@"%@",data);
                                                                   NSLog(@"==========");
                                                                   
                                                                   NSDictionary *json =
                                                                   [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions // NSJSONReadingAllowFragments
                                                                                                     error:&jsonError];
                                                                   
                                                                   NSInteger count = [[json allKeys] count];
                                                                   
                                                                   NSLog(@"count = %ld", (long)count);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletins" object:self userInfo:json];
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletins" object:self userInfo:nil];
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];
    
}

- (void) createBulletinCommentsTable:(NSString *)bulletinID companyID:(NSString *)companyID {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/bulletinREST/createBulletinCommentsTable.php"];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"company_id=%@&bulletin_id=%@", companyID, bulletinID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                           
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                                                   
                                                                   NSLog(@"Error 400");
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSLog(@"createBulletinCommentsTable Success");
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletinComments" object:self userInfo:nil];
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];

    
    
}

- (void) requestCommentsForBulletinID:(NSString *)bulletinID companyID:(NSString *)companyID {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *formattedUrl = [NSString stringWithFormat:@"http://marsguild.com/bulletinREST/getAvailableBulletinComments.php"];
    NSURL *url = [NSURL URLWithString:formattedUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"company_id=%@&bulletin_id=%@", companyID, bulletinID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data,
                                                                           NSURLResponse *response,
                                                                           NSError *error) {
                                                           
                                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                           
                                                           NSInteger statusCode = [httpResponse statusCode];
                                                           if (error == nil) {
                                                               
                                                               if(statusCode == 400) {
                                                                   
                                                                   NSLog(@"Error 400");
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletinComments" object:self userInfo:nil];
                                                                   
                                                               } else if (statusCode == 403) {
                                                                   
                                                                   NSLog(@"Error 403");
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletinComments" object:self userInfo:nil];
                                                                   
                                                               } else if (statusCode == 200) {
                                                                   
                                                                   NSError *jsonError;
                                                                   
                                                                   NSLog(@"==========");
                                                                   NSLog(@"%@",data);
                                                                   NSLog(@"==========");
                                                                   
                                                                   NSDictionary *json =
                                                                   [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions // NSJSONReadingAllowFragments
                                                                                                     error:&jsonError];
                                                                   
                                                                   NSInteger count = [[json allKeys] count];
                                                                   
                                                                   NSLog(@"count = %ld", (long)count);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletinComments" object:self userInfo:json];
                                                                   
                                                               } else {
                                                                   
                                                                   NSLog(@"Unexpected error: statusCode = %ld", (long)statusCode);
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceivedAvailableBulletinComments" object:self userInfo:nil];
                                                                   
                                                               }
                                                               
                                                           } else {
                                                               
                                                               NSLog(@"Error: %@", error.localizedDescription);
                                                               
                                                           }
                                                           
                                                       }];
    
    [dataTask resume];
    
}

@end
