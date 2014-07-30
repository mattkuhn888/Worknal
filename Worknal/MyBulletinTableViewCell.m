//
//  MyBulletinTableViewCell.mm
//  BulletinBlast
//
//  Created by Matt Kuhn
//  Copyright (c) 2014 Temp Name. All rights reserved.
//

#import "MyBulletinTableViewCell.h"

@implementation MyBulletinTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) prepareForReuse {
    [super prepareForReuse];
    
}


@end
