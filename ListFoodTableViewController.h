//
//  ListFoodTableViewController.h
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/29/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListFoodTableViewControllerDelegate

-(void)editingInfoWasFinished;

@end

@interface ListFoodTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    UITextField *detailfield;
    NSArray *arrState;
    UIPickerView *pktStatePicker ;
    UIToolbar *mypickerToolbar;
    
    
}

//@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
//
//@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
//
//@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (nonatomic, strong) id<ListFoodTableViewControllerDelegate> delegate;
@property (nonatomic) int recordIDToEdit;
//- (IBAction)saveInfo:(id)sender;
@property (nonatomic,strong) NSMutableArray *list;
@end
