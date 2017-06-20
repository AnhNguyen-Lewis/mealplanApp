//
//  ListFoodTableViewController.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/29/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "ListFoodTableViewController.h"
#import "food.h"
#import "modul.h"
#import "ViewController.h"
#import "ListFoodTableViewCell.h"
#import "AddMealViewController.h"
#import "DBManager.h"
@interface ListFoodTableViewController ()
    @property (nonatomic, strong) DBManager *dbManager;
    @property (nonatomic, strong) NSArray *arrFoodInfo;
@end

@implementation ListFoodTableViewController
@synthesize list;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"database.sql"];

    
    NSString *query;
//    query = [NSString stringWithFormat:@"delete from foodInfo"];
//    [self.dbManager executeQuery:query];
    query = [NSString stringWithFormat:@"select * from foodInfo"];
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if ([results count] == 0){
    
    
    query = [NSString stringWithFormat:@"insert into foodInfo values(null, '%@', '%@', %d)", @"Chicken",@"High Protein - Low Fat - Hard To Eat", 100];
    [self.dbManager executeQuery:query];
    
    query = [NSString stringWithFormat:@"insert into foodInfo values(null, '%@', '%@', %d)", @"Pork",@"Medium Protein - Medium Fat - Medium To Eat", 80];
    [self.dbManager executeQuery:query];
    query = [NSString stringWithFormat:@"insert into foodInfo values(null, '%@', '%@', %d)", @"Beef",@"Medium Protein - Medium Fat - Easy To Eat", 85];
    [self.dbManager executeQuery:query];
    query = [NSString stringWithFormat:@"insert into foodInfo values(null, '%@', '%@', %d)", @"Shrimp",@"Medium Protein - Low Fat - Easy To Eat", 80];
    [self.dbManager executeQuery:query];
    query = [NSString stringWithFormat:@"insert into foodInfo values(null, '%@', '%@', %d)", @"Turkey",@"High Protein - Low Fat - Medium To Eat", 95];
    [self.dbManager executeQuery:query];
    
    }
  
    arrState= [[NSArray alloc ]initWithObjects:
    @"High Protein - High Fat - Hard To Eat",@"High Protein - Mediem Fat - Hard To Eat",@"High Protein - Low Fat - Hard To Eat",@"High Protein - High Fat - Medium To Eat",@"High Protein - Medium Fat - Medium To Eat",@"High Protein - Low Fat - Medium To Eat",@"High Protein - High Fat - Easy To Eat",@"High Protein - Medium Fat - Easy To Eat",@"High Protein - Low Fat - Easy To Eat",@"Medium Protein - High Fat - Hard To Eat",@"Medium Protein - Medium Fat - Hard To Eat",@"Medium Protein - Low Fat - Hard To Eat",@"Medium Protein - High Fat - Medium To Eat",@"Medium Protein - Medium Fat - Medium To Eat",@"Medium Protein - Low Fat - Medium To Eat",@"Medium Protein - High Fat - Easy To Eat",@"Medium Protein - Medium Fat - Easy To Eat",@"Medium Protein - Low Fat - Easy To Eat",@"Low Protein - High Fat - Hard To Eat",@"Low Protein - Medium Fat - Hard To Eat",@"Low Protein - Low Fat - Hard To Eat",@"Low Protein - High Fat - Medium To Eat",@"Low Protein - Medium Fat - Medium To Eat",@"Low Protein - Low Fat - Medium To Eat",@"Low Protein - High Fat - Easy To Eat",@"Low Protein - Medium Fat - Easy To Eat",@"Low Protein - Low Fat - Easy To Eat", nil];
    
    pktStatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 43, 320, 300)];
    
    pktStatePicker.delegate = self;
    
    pktStatePicker.dataSource = self;
    
    [pktStatePicker setShowsSelectionIndicator:YES];
    // Create done button in UIPickerView
    mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];

    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData{
    // Form the query.
    NSString *query = @"select * from foodInfo";
    
    // Get the results.
    if (self.arrFoodInfo != nil) {
        self.arrFoodInfo = nil;
    }
    self.arrFoodInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrFoodInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    ListFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell)
        cell = [[ListFoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfDetail = [self.dbManager.arrColumnNames indexOfObject:@"detail"];
    NSInteger indexOfCal = [self.dbManager.arrColumnNames indexOfObject:@"calories"];
    
    // Set the loaded data to the appropriate cell labels.
    
    cell.foodTitle.text = [NSString stringWithFormat:@"%@", [[self.arrFoodInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfName]];
    cell.foodDetails.text = [NSString stringWithFormat:@"%@", [[self.arrFoodInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDetail]];
    cell.foodCalories.text = [NSString stringWithFormat:@"%@", [[self.arrFoodInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfCal]];
    cell.foodDetails.numberOfLines = 0;
    [cell.foodDetails sizeToFit];
    
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddMealViewController* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:@"AddMealViewController"];
    self.recordIDToEdit = [[[self.arrFoodInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    NSString *query = [NSString stringWithFormat:@"select * from foodInfo where foodInfoID=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the textfields.
    [modul shared].foodName = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    [modul shared].calories = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"calories"]];
    [modul shared].details = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"detail"]];

    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)createNewFood:(UIBarButtonItem *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Create New Food"
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"details";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"calories";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
        
    }];
    NSArray * textfields = alertController.textFields;
    detailfield = textfields[1];
    detailfield.inputView = pktStatePicker;

    
    detailfield.inputAccessoryView = mypickerToolbar;
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        //UITextField * detailsfield = textfields[1];
        
        
        UITextField * caloriesfield = textfields[2];
        int cal = [caloriesfield.text intValue];
        if (![namefield.text isEqual:@""] || ![detailfield.text isEqual:@""] || cal != 0){
            
            NSString *query;
            query = [NSString stringWithFormat:@"select * from foodInfo where name = %@", namefield];
            NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
            
            if ([results count] == 0){

            query = [NSString stringWithFormat:@"insert into foodInfo values(null, '%@', '%@', %d)", namefield.text,detailfield.text, cal];
            [self.dbManager executeQuery:query];
            }
            
            [self loadData];
        [self.tableView reloadData];
        }
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
//pickerview

-(void)pickerDoneClicked
{
    NSLog(@"Done Clicked");
    [detailfield resignFirstResponder];
    //mypickerToolbar.hidden=YES;
   //pktStatePicker.hidden=YES;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return [arrState count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    return [arrState objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    detailfield.text = [arrState objectAtIndex:row];
}

//delete

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* message = [NSString stringWithFormat:@"Do you want to delete this food?"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Food" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        int recordIDToDelete = [[[self.arrFoodInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from foodInfo where foodInfoID=%d", recordIDToDelete];
        
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

@end
