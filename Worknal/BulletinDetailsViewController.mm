//
//  BulletinDetailsViewController.mm
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import "BulletinDetailsViewController.h"
#import "PostBulletinCommentViewController.h"
#import "AppDelegate.h"
#import "BulletinComment.h"
#import "MBProgressHUD.h"
#import "MyCommentTableViewCell.h"

@interface BulletinDetailsViewController () <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *theCommentsTableView;

@property (nonatomic, strong) IBOutlet UILabel *numBulletinCommentsLabel;

@property (nonatomic, strong) NSDictionary *bulletinCommentsReceived;
@property (nonatomic, strong) NSMutableArray *bulletinCommentsArray;

@end

@implementation BulletinDetailsViewController

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
    
    _bulletinCommentsArray = [[ NSMutableArray alloc] init];
    
    //======================
    // TODO move to details
    //======================
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onReceivedAvailableBulletinComments:)
                                                 name:@"kReceivedAvailableBulletinComments"
                                               object:nil];
    //======================
    //======================
}

- (void)viewWillAppear:(BOOL)animated {
    
    //self.numberRating.text = self.bulletin.numberRating;
    self.from.text = self.bulletin.from;
    self.timestamp.text = self.bulletin.timestamp;
    self.comments.text = self.bulletin.comments;
    self.commentsLong.text = self.bulletin.commentsLong;
    
    NSLog(@"***** personID: %@", self.personID);
    NSLog(@"***** companyID: %@", self.companyID);
    NSLog(@"***** bulletinID: %@", self.bulletinID);
    
    if ( _webServer != nil) {
        [_webServer requestCommentsForBulletinID:self.bulletinID companyID:self.companyID];
    } else {
        NSLog(@"Webserver nil");
    }
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Gathering comments for this bulletin...";

    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    /* MOVED
    NSLog(@"***** personID: %@", self.personID);
    NSLog(@"***** companyID: %@", self.companyID);
    NSLog(@"***** bulletinID: %@", self.bulletinID);
    
    if ( _webServer != nil) {
        [_webServer requestCommentsForBulletinID:self.bulletinID companyID:self.companyID];
    } else {
        NSLog(@"Webserver nil");
    }
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Gathering comments for this bulletin...";
     */
    
}

- (void)didReceiveMemoryWarning {
    
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


-(IBAction) onBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction) pressedContact:(id) sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setToRecipients:[NSArray arrayWithObjects:self.from.text, nil]];
        [mailViewController setSubject:@"I'm interested in..."];
        
        /*
         NSString *msg = [NSString stringWithFormat:@"Hi! Would you spend just a minute to give me feedback? Please click the link below:\n\r http://marsguild.com/rating.php?u=%@&id=%@",
         [AppDelegate instance].loggedInEmailAddress,
         self.personID];
         */
        
        NSString *msg = [NSString stringWithFormat:@"Hi! I'm interested in your bulletin item: \n\r\n\r%@\n\r\n\r", self.comments.text];
        
        [mailViewController setMessageBody:msg isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:nil];
        //[mailViewController release];
        
    } else {
        
        NSLog(@"Device is unable to send email in its current state.");
        
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 

- (void) onCommentRecommend {
    
    // Post to the current posting:
    
    
    
}

#pragma mark - IBAction methods

-(IBAction)onPressedPostBulletinComment:(id)sender {
    
    UIStoryboard *theStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
    PostBulletinCommentViewController *postCommentVC = [theStoryboard instantiateViewControllerWithIdentifier:@"postcommentVC"];
    
    [postCommentVC setCompanyID:_companyID];
    [postCommentVC setBulletinID:_bulletinID];
    [postCommentVC setFrom:[[AppDelegate instance] loggedInEmailAddress]];
    [self presentViewController:postCommentVC animated:YES completion:nil];
    
}


//////////////////
//////////////////


- (void)onReceivedAvailableBulletinComments:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"kReceivedAvailableBulletinComments"]) {
        
        /*
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bulletin comments received from server"
         message:nil delegate:self
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil, nil];
         [alertView show];
         */
        
        self.bulletinCommentsReceived = [notification userInfo];
        
        NSLog(@"--------------------------");
        NSLog(@"Bulletin Comments received");
        NSLog(@"--------------------------");
        NSLog(@"%@",self.bulletinCommentsReceived);
        NSLog(@"--------------------------");
        
        
        [self parseDictionaryForBulletinCommentsReceived:self.bulletinCommentsReceived];
        
        [self.theCommentsTableView reloadData]; // TODO NOW Now this needs to be the table view of the detail view.
        
    }
}

//////////////////
//////////////////

- (void) parseDictionaryForBulletinCommentsReceived:(NSDictionary *)dictionary {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_bulletinCommentsArray removeAllObjects];
    
    
    NSUInteger numBulletinComments = [[dictionary allKeys] count];
    NSArray *sortedKeys = [[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSUInteger i=0; i<numBulletinComments; i++) {
        
        NSDictionary *ratingDict = [dictionary objectForKey:sortedKeys[i]];
        
        NSLog(@"rating %lu: %@", (unsigned long)i, ratingDict);
        
        //NSString *numberRating = [ratingDict objectForKey:@"number_rating"];
        NSString *comments = [ratingDict objectForKey:@"comments"];
        NSString *commentsLong = [ratingDict objectForKey:@"comments_long"];
        NSString *from = [ratingDict objectForKey:@"from"];
        NSString *timestamp = [ratingDict objectForKey:@"timestamp"];
        
        //NSLog(@"%@",numberRating);
        NSLog(@"%@",comments);
        NSLog(@"%@",commentsLong);
        NSLog(@"%@",from);
        NSLog(@"%@",timestamp);
        
        BulletinComment *bulletinComment = [[BulletinComment alloc] init];
        
        //bulletinComment.numberRating = [numberRating copy];
        bulletinComment.comments = [comments copy];
        bulletinComment.commentsLong = [commentsLong copy];
        bulletinComment.from = [from copy];
        bulletinComment.timestamp = [timestamp copy];
        
        [_bulletinCommentsArray addObject:bulletinComment];
        
    } // end for
    
    NSString *txt;
    if ( numBulletinComments == 1) {
        txt = [NSString stringWithFormat:@"Found %lu bulletin comment:", (unsigned long)numBulletinComments];
    } else {
        txt = [NSString stringWithFormat:@"Found %lu bulletin comments:", (unsigned long)numBulletinComments];
    }
    
    self.numBulletinCommentsLabel.text = txt;
    
}

////////////////////////////////////////////////////////////////////////////////////////////
//
// TableView routines
//
////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger count = 0;
    count = [self.bulletinCommentsArray count]; //[[self.usersFeedbackReceived allKeys] count];
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //static NSString *CellIdentifier = @"Cell";
 
    MyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellComments" forIndexPath:indexPath];
    
    BulletinComment *bulletinComment = _bulletinCommentsArray[indexPath.row];
    
    //cell.numberRating.text = bulletin.numberRating;
    cell.comments.text = bulletinComment.comments; //key; //@"Bob is steller";
    cell.from.text = bulletinComment.from; //@"jim@microsoft.com";
    //cell.timestamp.text = bulletin.timestamp; //@"April 26, 2014 5:55 PM";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* TODO

    BulletinComment *bulletinComment = _bulletinCommentsArray[indexPath.row];
    
    self.bulletinDetailsVC.webServer = self.webServer; // set weakist ptr
    
    //self.bulletinDetailsVC.numberRating.text = bulletin.numberRating;
    self.bulletinDetailsVC.from.text = bulletin.from;
    self.bulletinDetailsVC.timestamp.text = bulletin.timestamp;
    self.bulletinDetailsVC.comments.text = bulletin.comments;
    self.bulletinDetailsVC.commentsLong.text = bulletin.commentsLong;
    
    self.bulletinDetailsVC.bulletin = bulletin;
    
    self.bulletinDetailsVC.personID = self.personID;
    self.bulletinDetailsVC.companyID = self.companyID;
    self.bulletinDetailsVC.bulletinID = self.bulletinID;
    
    [self presentViewController:self.bulletinDetailsVC animated:YES completion:nil];
     
     */
}



@end
