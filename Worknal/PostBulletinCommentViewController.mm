//
//  PostBulletinCommentViewController.m
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import "PostBulletinCommentViewController.h"

@interface PostBulletinCommentViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *theWebView;

@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation PostBulletinCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //NSString *urlAddress = @"http://www.marsguild.com";
    NSString *urlAddress = [NSString stringWithFormat:@"http://www.marsguild.com/bulletinComment.php?id=%@&bulletin=%@&from=%@", _companyID, _bulletinID, _from];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_theWebView loadRequest:requestObj];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"shouldStartLoadWithRequest");
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidFinishLoad");
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"didFailLoadWithError");
    
}

#pragma mark - IBAction methods

- (IBAction)onDone:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
