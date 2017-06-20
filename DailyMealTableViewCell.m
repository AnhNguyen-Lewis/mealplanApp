//
//  DailyMealTableViewCell.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/30/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "DailyMealTableViewCell.h"

@implementation DailyMealTableViewCell
@synthesize name,total;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
