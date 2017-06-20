//
//  modul.h
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/30/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface modul : NSObject
@property (strong,nonatomic) NSString* foodName;
@property (strong,nonatomic) NSString* calories;
@property (strong,nonatomic) NSString* details;
@property (strong,nonatomic) NSString* total;
@property (strong,nonatomic) NSString* mealTime;
@property (strong,nonatomic) NSMutableArray* breakfast;
@property (strong,nonatomic) NSMutableArray* lunch;
@property (strong,nonatomic) NSMutableArray* dinner;
+ (modul*) shared;
-(void)share;
@end
