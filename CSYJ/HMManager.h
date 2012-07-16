//
//  HMManager.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDataBase.h"

typedef enum 
{
    ttSimplified,
    ttTraditional,
} TEXT_TYPE;



@interface HMManager : NSObject
{
    TEXT_TYPE       textType;
    HMDataBase      *hmdb;
    NSMutableArray  *hmArray;
    NSArray         *hmUnits; //药物分组
    NSString        *searchText;
}

@property (assign, nonatomic) TEXT_TYPE textType;

+ (HMManager*)defaultManager;
- (void)Reset;
- (NSInteger)ItemsCount;
- (HerbalMedicine*)objectAtIndex:(NSInteger)index;
- (void)Search:(NSString*)text;
- (NSInteger)UnitCount;
- (NSInteger)ItemsCountAtUnit:(NSInteger)unit;
- (HerbalMedicine*)objectAtUnit:(NSInteger)unit forIndex:(NSInteger)index;
- (HerbalMedicine*)nextObjectAtUnit:(NSInteger)unit forIndex:(NSInteger)index;
- (HerbalMedicine*)lastObjectAtUnit:(NSInteger)unit forIndex:(NSInteger)index;
- (NSIndexPath*)indexOfObject:(HerbalMedicine*)hmObject;
@end
