//
//  HMDataBase.h
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define HM_TABLE_NAME @"herbal_medicine"
#define DATA_BASE_NAME @"csyj.db"

@interface HerbalMedicine : NSObject
{
    NSInteger ID;
    NSInteger unit;
    NSString* name;
    NSString* description;
    NSString* summary;
    NSString* classicUse;
    NSString* shennong;
    BOOL      bookMark;
}


- (NSString *)getCaption;
- (NSString *)getDescription;
- (NSString *)getSummary;
- (NSString *)getClassicUse;
- (NSString *)getShennong;

@property NSInteger ID;
@property NSInteger unit;
@property(nonatomic, retain) NSString*  name;
@property(getter = getDescription , nonatomic, retain) NSString*  description;
@property(getter = getSummary , nonatomic, retain) NSString*  summary;
@property(getter = getClassicUse, nonatomic, retain) NSString*  classicUse;
@property(getter = getShennong, nonatomic, retain) NSString*  shennong;
@property(getter = getCaption, readonly) NSString* caption;
@property(nonatomic)BOOL bookMakr;
@end

@interface HMDataBase : NSObject
{
    NSString*               dbFile;
    FMDatabase*             fmdb;
    NSMutableArray *        hmArray;
}

@property(nonatomic, retain) NSMutableArray* hmArray;

-(id)initWithFile:(NSString*)fileName;
-(BOOL)Load;

@end
