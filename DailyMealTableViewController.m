//
//  DailyMealTableViewController.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/30/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "DailyMealTableViewController.h"
#import "modul.h"
#import "DailyMealTableViewCell.h"
#import "DBManager.h"
@interface DailyMealTableViewController ()
//@property (weak, nonatomic) IBOutlet UITableView *tableViews;
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrBreakFastInfo;
@property (nonatomic, strong) NSArray *arrLunchInfo;
@property (nonatomic, strong) NSArray *arrDinnerInfo;

@end

@implementation DailyMealTableViewController
{
    NSMutableArray* tableDataCell1;
    NSMutableArray* tableDataCell2;
    NSMutableArray* tableDataCell3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //tableDataCell1=[[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
//    tableDataCell1 = [NSMutableArray array];
//    tableDataCell2 = [NSMutableArray array];
//    tableDataCell3 = [NSMutableArray array];
//    tableDataCell1 = [[modul shared].breakfast mutableCopy];
//    tableDataCell2 = [[modul shared].lunch mutableCopy];
//    tableDataCell3 = [[modul shared].dinner mutableCopy];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"database.sql"];
    
    
//    NSString *query;
//        query = [NSString stringWithFormat:@"delete from breakfastInfo"];
//        [self.dbManager executeQuery:query];
    //query = [NSString stringWithFormat:@"select * from foodInfo"];
    //NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            //tableDataCell1 = [modul shared].breakfast;
            return [self.arrBreakFastInfo count];
        case 1:
            //tableDataCell1 = [modul shared].lunch;
            return [self.arrLunchInfo count];
        case 2:
            //tableDataCell1 = [modul shared].dinner;
            return [self.arrDinnerInfo count];
    }
    return 0;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Breakfast";
            break;
        case 1:
            return @"Lunch";
            break;
        case 2:
            return @"Dinner";
        default:
            break;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    DailyMealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell)
        cell = [[DailyMealTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    if (indexPath.section == 0){
        //NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"foodname"];
        
        //NSInteger indexOfTotal = [self.dbManager.arrColumnNames indexOfObject:@"total"];
        
        // Set the loaded data to the appropriate cell labels.
        
        cell.name.text = [NSString stringWithFormat:@"%@", [[self.arrBreakFastInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
        
        cell.total.text = [NSString stringWithFormat:@"%@", [[self.arrBreakFastInfo objectAtIndex:indexPath.row] objectAtIndex:2]];
        
//        
//        NSDictionary *dict = [tableDataCell1 objectAtIndex:indexPath.row];
//        cell.name.text = [dict valueForKey:@"name"];
//        cell.total.text =[NSString stringWithFormat:@"%@",[dict valueForKey:@"weight"]];
    }
    else if (indexPath.section == 1){
//        NSDictionary *dict = [tableDataCell2 objectAtIndex:indexPath.row];
//        cell.name.text = [dict valueForKey:@"name"];
//        cell.total.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"weight"]];
        
        cell.name.text = [NSString stringWithFormat:@"%@", [[self.arrLunchInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
        
        cell.total.text = [NSString stringWithFormat:@"%@", [[self.arrLunchInfo objectAtIndex:indexPath.row] objectAtIndex:2]];
    }
    else if (indexPath.section == 2){
//        NSDictionary *dict = [tableDataCell3 objectAtIndex:indexPath.row];
//        cell.name.text = [dict valueForKey:@"name"];
//        cell.total.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"weight"]];
        
        cell.name.text = [NSString stringWithFormat:@"%@", [[self.arrDinnerInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
        
        cell.total.text = [NSString stringWithFormat:@"%@", [[self.arrDinnerInfo objectAtIndex:indexPath.row] objectAtIndex:2]];
    }

    
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* message = [NSString stringWithFormat:@"Do you want to delete this meal?"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Meal" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.section == 0) {
            int recordIDToDelete = [[[self.arrBreakFastInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
            
            // Prepare the query.
            NSString *query = [NSString stringWithFormat:@"delete from breakfastInfo where breakfastInfoID=%d", recordIDToDelete];
            
            // Execute the query.
            [alertController addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.dbManager executeQuery:query];
                
                // Reload the table view.
                [self loadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
           
        else if (indexPath.section == 1) {
            int recordIDToDelete = [[[self.arrLunchInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
            
            // Prepare the query.
            NSString *query = [NSString stringWithFormat:@"delete from lunchInfo where lunchInfoID=%d", recordIDToDelete];
            
            // Execute the query.
            [alertController addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.dbManager executeQuery:query];
                
                // Reload the table view.
                [self loadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        

    
        } else{
            int recordIDToDelete = [[[self.arrDinnerInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
            
            // Prepare the query.
            NSString *query = [NSString stringWithFormat:@"delete from dinnerInfo where dinnerInfoID=%d", recordIDToDelete];
            
            // Execute the query.
            [alertController addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.dbManager executeQuery:query];
                
                // Reload the table view.
                [self loadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }

}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from breakfastInfo";
    
    // Get the results.
    if (self.arrBreakFastInfo != nil) {
        self.arrBreakFastInfo = nil;
    }
    self.arrBreakFastInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    query = @"select * from lunchInfo";
    
    // Get the results.
    if (self.arrLunchInfo != nil) {
        self.arrLunchInfo = nil;
    }
    self.arrLunchInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    query = @"select * from dinnerInfo";
    
    // Get the results.
    if (self.arrDinnerInfo != nil) {
        self.arrDinnerInfo = nil;
    }
    self.arrDinnerInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tableView reloadData];
}

@end
