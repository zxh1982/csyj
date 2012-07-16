//
//  HMManager.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HMManager.h"

@implementation HMManager

@synthesize textType;


//静态创建HMManager
+ (HMManager*)defaultManager
{
    static HMManager *instance;
    
    if (instance == NULL)
    {
        instance = [[HMManager alloc]init];
    }
    
    return instance;
}

//初始化
- (HMManager*)init
{
    self = [super init];
    if (self)
    {
        NSString* dataFileName =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:DATA_BASE_NAME];
        //加载数据库对象
        hmdb = [[HMDataBase alloc]initWithFile:dataFileName];
        if ([hmdb Load] == FALSE)
        {
            NSLog(@"load data base failed!");
        }
        //保存药物数据到成员
        hmArray = [[NSMutableArray alloc] initWithArray:hmdb.hmArray];
        
        //创建分卷
        NSMutableArray *hmUnit1 = [[[NSMutableArray alloc] init]autorelease];
        NSMutableArray *hmUnit2 = [[[NSMutableArray alloc] init]autorelease];
        NSMutableArray *hmUnit3 = [[[NSMutableArray alloc] init]autorelease];
        NSMutableArray *hmUnit4 = [[[NSMutableArray alloc] init]autorelease];
        
        for (int i = 0; i < hmArray.count; i++)
        {
            HerbalMedicine *hmObject = [hmArray objectAtIndex:i];
            switch (hmObject.unit) 
            {
                case 1:
                    [hmUnit1 addObject:hmObject];break;
                case 2:
                    [hmUnit2 addObject:hmObject];break;
                case 3:
                    [hmUnit3 addObject:hmObject];break;
                case 4:
                    [hmUnit4 addObject:hmObject];break;
            }
        }
        
        hmUnits = [NSArray arrayWithObjects:
                   hmUnit1,
                   hmUnit2, 
                   hmUnit3, 
                   hmUnit4,
                   nil];
        [hmUnits retain];
        searchText = [NSString stringWithString:@""];
    }
    
    return self;
}

//取得当前Item总个数
- (NSInteger)ItemsCount
{
    return [hmArray count];
}

//取得卷数
- (NSInteger)UnitCount
{
    return [hmUnits count];
}

//通过索引取得uint下的个数
- (NSInteger)ItemsCountAtUnit:(NSInteger)unit;
{
    NSArray *array = [hmUnits objectAtIndex:unit];
    return [array count];
}

//通过Index取得HM
- (HerbalMedicine*)objectAtIndex:(int)index
{
    return [hmArray objectAtIndex:index];
}

- (HerbalMedicine*)objectAtUnit:(NSInteger)unit forIndex:(NSInteger)index
{
    NSLog(@"%d", [hmUnits retainCount]);
    NSArray *array = [hmUnits objectAtIndex:unit];
   
    return [array objectAtIndex:index];
    //return [[hmUnits objectAtIndex:unit] objectAtIndex: index];
}

//通过当前unit+index 返回下一个hmObject
- (HerbalMedicine*)nextObjectAtUnit:(NSInteger)unit forIndex:(NSInteger)index
{
    HerbalMedicine* hmObject = nil;
    NSArray *array = [hmUnits objectAtIndex:unit];
    if (index + 1 < [array count])
    {
        hmObject = [array objectAtIndex:index + 1];
    }
    else if (unit + 1 < [hmUnits count])
    {
        NSArray *array = [hmUnits objectAtIndex:unit + 1];
        hmObject = [array objectAtIndex:0];
    }
    NSLog(@"%@",hmObject.name);

    return hmObject;
}

//通过当前unit+index 返回上一个hmObject
- (HerbalMedicine*)lastObjectAtUnit:(NSInteger)unit forIndex:(NSInteger)index
{
    HerbalMedicine* hmObject = nil;
    NSArray *array = [hmUnits objectAtIndex:unit];
    if (index - 1 >= 0)
    {
        hmObject = [array objectAtIndex:index - 1];
    }
    else if (unit - 1 >= 0)
    {
        NSArray *array = [hmUnits objectAtIndex:unit - 1];
        hmObject = [array lastObject];
    }
    NSLog(@"%@",hmObject.name);
    return hmObject;
}

//通过hmObject查询所在Unit+index
- (NSIndexPath*)indexOfObject:(HerbalMedicine*)hmObject
{
    NSLog(@"%@, %d, %d, %d", hmObject.name, [hmObject retainCount], [hmUnits retainCount], hmObject.unit);
    NSArray *array = [hmUnits objectAtIndex:hmObject.unit - 1];
    NSLog(@"%d, %d", [array retainCount], [array count]);
    
    NSInteger index = [array indexOfObjectIdenticalTo:hmObject];
    
    if (index == NSNotFound)
    {
        return nil;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:hmObject.unit - 1];
    NSLog(@"unit:%d, index:%d", [indexPath section], [indexPath row]);
    return indexPath;
}


//重新加载数据
- (void)Reset
{
    [hmArray removeAllObjects];
    hmArray = [[NSMutableArray alloc] initWithArray:hmdb.hmArray];
}

//搜索
- (void)Search:(NSString*)text
{
    if (text.length == 0)
    {
        [self Reset];
        return;
    }
    
    [hmArray removeAllObjects];
    for (HerbalMedicine* hmObject in hmdb.hmArray)
    {
        if ([hmObject.name rangeOfString:text].location == NSNotFound &&
            [hmObject.description rangeOfString:text].location == NSNotFound)
        {
        
        }
        else
        {
            [hmArray addObject:hmObject];
        }
    }
}


- (void)dealloc
{
    [hmUnits release];
    [searchText release];
    [hmArray release];
    [hmdb release];
}

@end
