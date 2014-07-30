//
//  BulletinDetailsViewController.h
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "Bulletin.h"

#import "TalkToWebServerViewController.h"

@interface BulletinDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *personID;
@property (nonatomic, strong) NSString *companyID;
@property (nonatomic, strong) NSString *bulletinID;

//@property (nonatomic, retain) IBOutlet UILabel *numberRating;
@property (nonatomic, retain) IBOutlet UITextView *comments;
@property (nonatomic, retain) IBOutlet UITextView *commentsLong;
@property (nonatomic, retain) IBOutlet UILabel *from;
@property (nonatomic, retain) IBOutlet UILabel *timestamp;

@property (nonatomic, retain) Bulletin *bulletin;

@property (nonatomic, assign) TalkToWebServerViewController *webServer; // weak-ish ref

@end
