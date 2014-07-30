//
//  TalkToWebServerViewController.h
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkToWebServerViewController : UIViewController

- (void) requestUsersFeedbackForUUID:(NSString *)uuid;
- (void) requestUsersFeedbackForPersonID:(NSString *)personID;

- (void) createBulletinCommentsTable:(NSString *)bulletinID companyID:(NSString *)companyID;

- (void) requestCommentsForBulletinID:(NSString *)bulletinID companyID:(NSString *)companyID;

- (void) requestBulletinsForCompanyID:(NSString *)companyID;
- (void) createUserIfDoesntExistWithEmail:(NSString *)email;
- (void) createCompanyIfDoesntExistWithDomain:(NSString *)companydomain;

@end
