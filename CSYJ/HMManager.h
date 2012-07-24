//
//  HMManager.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDataBase.h"

#define FILE_BOOK_MARK  @"BookMark.dat.strings"


typedef enum 
{
    ttSimplified,
    ttTraditional,
} TEXT_TYPE;

typedef enum
{
    tsSmall,
    tsMiddle,
    tsBig,
} TEXT_SIZE;


@interface HMManager : NSObject
{
    TEXT_TYPE       textType;
    TEXT_SIZE       textSize;
    HMDataBase      *hmdb;
    NSMutableArray  *hmArray;
    NSArray         *hmUnits; //药物分组
    NSString        *searchText;
    //NSMutableDictionary    *bookMark; //书签配置
    //NSMutableArray  *hmBookMark;      //书签中的药物对象
}

@property (assign, nonatomic) TEXT_TYPE textType;
@property (assign, nonatomic) TEXT_SIZE textSize;
//@property (retain, nonatomic) NSMutableDictionary *bookMark;


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
- (NSInteger)getTextFontSize;
- (void)setBookMark:(NSInteger)unit forIndex:(NSInteger)index;

- (NSArray*) GetBookMarkArray;

@end
