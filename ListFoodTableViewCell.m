//
//  ListFoodTableViewCell.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/29/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "ListFoodTableViewCell.h"
#import "food.h"
@implementation ListFoodTableViewCell
@synthesize foodTitle,foodCalories,foodDetails;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
