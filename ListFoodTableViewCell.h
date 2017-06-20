//
//  ListFoodTableViewCell.h
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/29/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListFoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UILabel *foodDetails;
@property (weak, nonatomic) IBOutlet UILabel *foodCalories;
@end
