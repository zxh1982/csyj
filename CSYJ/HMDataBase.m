//
//  HMDataBase.m
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HMDataBase.h"
#import "ConvertJF.h"
#import "HMManager.h"

@implementation HerbalMedicine
    
@synthesize ID;
@synthesize unit;
@synthesize name;
@synthesize description;
@synthesize summary;
@synthesize classicUse;
@synthesize shennong;


- (NSString *)getCaption
{
    if ([[HMManager defaultManager] textType] == ttSimplified) 
        return name;
    else
        return [[ConvertJF getInstance]convert:name];
}

- (NSString *)getDescription
{
    if ([[HMManager defaultManager] textType] == ttSimplified) 
        return description;
    else
        return [[ConvertJF getInstance]convert:description];

}

- (NSString *)getSummary
{
    if (summary == nil)
    {
        summary = [NSString stringWithString:@""];
    }
    
    if ([[HMManager defaultManager] textType] == ttSimplified) 
        return summary;
    else
        return [[ConvertJF getInstance]convert:summary];

}

- (NSString *)getClassicUse
{
    if ([[HMManager defaultManager] textType] == ttSimplified) 
        return classicUse;
    else
        return [[ConvertJF getInstance]convert:classicUse];

}

- (NSString *)getShennong
{
    if ([[HMManager defaultManager] textType] == ttSimplified) 
        return shennong;
    else
        return [[ConvertJF getInstance]convert:shennong];
}
@end


//------------------------------------

@implementation HMDataBase
@synthesize hmArray;

-(id)initWithFile:(NSString *)fileName
{
    self = [super init];
    dbFile = [[NSString alloc] initWithString:fileName];
    fmdb = [[FMDatabase alloc]initWithPath:fileName];
    fmdb.logsErrors = TRUE;
    NSMutableArray* array = [[NSMutableArray alloc]init];
    self.hmArray = array;
    [array release];
    return self;
}

-(BOOL)Load
{
    BOOL rt = [fmdb open];
    if (rt == FALSE)
    {
        return rt;
    }
    
    NSString* sql = @"select csyj_herbal_medicine.ID as ID, csyj_herbal_medicine.unit as unit, csyj_herbal_medicine.name as name, \
                    csyj_herbal_medicine.description as desc, csyj_herbal_medicine.summary as summary, \
                    csyj_herbal_medicine.classicUse as classicUse, ben_jing.description as shenglong \
                    from csyj_herbal_medicine \
                    left join ben_jing \
                    on csyj_herbal_medicine.name = ben_jing.name";
    
    FMResultSet* fmset = [fmdb executeQuery:sql];
    
    if (fmset == nil)
    {
        return FALSE;
    }
    
    while ([fmset next])
    {
        HerbalMedicine* hm = [[[HerbalMedicine alloc]init] autorelease];
        hm.ID   =  [fmset intForColumn:@"ID"];
        hm.unit =  [fmset intForColumn:@"unit"];
        hm.name =  [fmset stringForColumn:@"name"];
        hm.description = [fmset stringForColumn:@"desc"];
        hm.summary = [fmset stringForColumn:@"summary"];
        hm.classicUse = [fmset stringForColumn:@"classicUse"];
        hm.shennong = [fmset stringForColumn:@"shenglong"];
        [hmArray addObject:hm];
    }
    
    [fmset close];
    return TRUE;
}

-(void)dealloc
{
    [hmArray removeAllObjects];
    [hmArray release];
    [fmdb close];
    [fmdb release];
    [super dealloc];
}



@end
