//
//  AddMealViewController.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/29/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "AddMealViewController.h"
#import "food.h"
#import "modul.h"
#import "ViewController.h"
#import "DBManager.h"
@interface AddMealViewController ()
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *details;
@property (strong, nonatomic) IBOutlet UILabel *calories;


@property (strong, nonatomic) IBOutlet UITextField *weight;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mealTime;

@property (nonatomic, strong) DBManager *dbManager;
@end

@implementation AddMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = [modul shared].foodName;
    self.details.text = [modul shared].details;
    self.calories.text = [modul shared].calories;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"database.sql"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clicked:(UIButton *)sender {
    double a = [self.weight.text doubleValue];
    NSInteger b = [[modul shared].calories integerValue];
    NSString* product = [NSString stringWithFormat:@"%.2f",a * b];
    //[modul shared].total = product;
    //[modul shared].mealTime = [_mealTime titleForSegmentAtIndex:_mealTime.selectedSegmentIndex];
    int total = [product intValue];
    //NSString* title = [NSString stringWithFormat:@"",];
    NSString* message = [NSString stringWithFormat:@"%@ with %@ calories",[modul shared].foodName, product];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add meal" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        switch(_mealTime.selectedSegmentIndex){
            case 0:
            {
               // [[modul shared].breakfast addObject:@{@"name" : [modul shared].foodName,          @"weight":product}];
                NSString *query;
                query = [NSString stringWithFormat:@"insert into breakfastInfo values(null, '%@', %d)", [modul shared].foodName, total];
                [self.dbManager executeQuery:query];
            }
                break;
            case 1:
            {
                //[[modul shared].lunch addObject:@{@"name" : [modul shared].foodName,      @"weight":product}];
                NSString *query;
                query = [NSString stringWithFormat:@"insert into lunchInfo values(null, '%@', %d)", [modul shared].foodName, total];
                [self.dbManager executeQuery:query];
            }
                break;
            case 2:{
                //[[modul shared].dinner addObject:@{@"name" : [modul shared].foodName,       @"weight":product}];
                NSString *query;
                query = [NSString stringWithFormat:@"insert into dinnerInfo values(null, '%@', %d)", [modul shared].foodName, total];
                [self.dbManager executeQuery:query];
            }
                break;
            default:
                break;
        }
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        
        [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"date"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        ViewController *listVC =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:listVC animated:YES];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
