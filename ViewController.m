//
//  ViewController.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/29/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "AddMealViewController.h"
#import "ListFoodTableViewCell.h"
#import "ListFoodTableViewController.h"
#import "food.h"
#import "DailyMealTableViewController.h"
#import "DBManager.h"
@interface ViewController ()
@property (nonatomic, strong) DBManager *dbManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"date"];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [f dateFromString:savedValue];
    NSDate *endDate = [f dateFromString:dateString];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"database.sql"];
//    
//    NSTimeInterval secondsBetween = [startDate timeIntervalSinceDate:endDate];
//    
//    int numberOfDays = secondsBetween / 86400;
    NSString *query;
    
    if ([components day] !=0){
        query = [NSString stringWithFormat:@"delete from breakfastInfo"];
        
        [self.dbManager executeQuery:query];
        
        query = [NSString stringWithFormat:@"delete from lunchInfo"];
        
        [self.dbManager executeQuery:query];
        
        query = [NSString stringWithFormat:@"delete from dinnerInfo"];
        
        [self.dbManager executeQuery:query];
        
    }
    
}

- (IBAction)addButton:(UIBarButtonItem *)sender {
    
    if (sender){
        ListFoodTableViewController *listVC =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListFoodTableViewController"];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

- (IBAction)listButton:(UIBarButtonItem *)sender {
    if (sender){
        DailyMealTableViewController *listVC =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DailyMealTableViewController"];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
