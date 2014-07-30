//
//  MyCommentTableViewCell.h
//  BulletinBlast
//
//  Created by Matt Kuhn on 7/7/14.
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BulletinComment;

@interface MyCommentTableViewCell : UITableViewCell

//@property (nonatomic, retain) IBOutlet UILabel *numberRating;
@property (nonatomic, retain) IBOutlet UILabel *comments;
@property (nonatomic, retain) IBOutlet UITextView *commentsLong;
@property (nonatomic, retain) IBOutlet UILabel *from;
@property (nonatomic, retain) IBOutlet UILabel *timestamp;

@property (nonatomic, retain) BulletinComment *bulletinComment;
@end
