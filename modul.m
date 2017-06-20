//
//  modul.m
//  PracticeUI
//
//  Created by Lewis Nguyen on 5/30/17.
//  Copyright © 2017 Lewis Nguyen. All rights reserved.
//

#import "modul.h"
static modul* mode = nil;

@implementation modul
+ (modul*)shared
{
    if (mode) return mode;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mode = [[modul alloc] init];
        mode.breakfast = [NSMutableArray new];
        mode.lunch = [NSMutableArray new];
        mode.dinner = [NSMutableArray new];
    });
    return mode;
}
-(void)share{
}
@end
