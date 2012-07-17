//
//  HMDataBase.m
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HMDataBase.h"

@implementation HerbalMedicine
    
@synthesize ID;
@synthesize unit;
@synthesize name;
@synthesize description;
@synthesize summary;
@synthesize classicUse;
@synthesize shennong;

- (HerbalMedicine *)init
{
	//加载字典文件
    NSString *dictFile =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Dictionary.txt"];
    NSString *dictString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSArray  *dictArray = [dictString componentsSeparatedByString:@"\n"];
    
    NSMutableDictionary *dict = [NSMutableDictionary alloc] init];
	for (NSString *str in dictArray)
	{
        unichar key = [str characterAtIndex:0];
        unichar value = [str characterAtIndex:1];
        [dict setObject:value forKey: key]
	}
}

-(NSString *)ConvertZh2Hant:(NSString*)text
{
    NSInteger length = [text length];
	for (NSInteger i = 0; i< length; i++)
	{
		NSString *string = [text substringWithRange:NSMakeRange(i, 1)];
        NSString *hantString = [dict objectForKey:string];

		if(hantString != nil)
		{
			text = [text stringByReplacingCharactersInRange:NSMakeRange(i, 1)
											   withString:hantString];
		}
	}
	
	return srcString;
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
