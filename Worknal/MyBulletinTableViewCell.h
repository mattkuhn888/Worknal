//
//  MyBulletinTableViewCell.h
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bulletin;

@interface MyBulletinTableViewCell : UITableViewCell

//@property (nonatomic, retain) IBOutlet UILabel *numberRating;
@property (nonatomic, retain) IBOutlet UILabel *comments;
@property (nonatomic, retain) IBOutlet UITextView *commentsLong;
@property (nonatomic, retain) IBOutlet UILabel *from;
@property (nonatomic, retain) IBOutlet UILabel *timestamp;

@property (nonatomic, retain) Bulletin *bulletin;

@end

