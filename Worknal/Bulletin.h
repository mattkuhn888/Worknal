//
//  Bulletin.h
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bulletin : NSObject

//@property (nonatomic, retain) NSString *numberRating;
@property (nonatomic, retain) NSString *comments;
@property (nonatomic, retain) NSString *commentsLong;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, retain) NSString *theID;

@end
