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
@synthesize textSize;
//@synthesize bookMark;

- (void)SaveBookMark
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:FILE_BOOK_MARK];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < hmArray.count; i++)
    {
        HerbalMedicine *hmObject = [hmArray objectAtIndex:i];
        if (hmObject.bookMakr)
        {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    
    [array writeToFile:path atomically:TRUE];
    [array release];
}

- (void)LoadBookMark
{
    //[NSFileManager defaultManager] d
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:FILE_BOOK_MARK];
    
    
    NSArray* array;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) 
    {
       array = [[NSMutableArray alloc] init];
    }
    else
    {
        array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
        
    //设置书签标记
    for (NSString *key in array)
    {
        NSInteger hmID = [key intValue];
        HerbalMedicine *hmObject = [self objectAtIndex:hmID];
        hmObject.bookMakr = TRUE;
    }
    
    [array release];
}

- (NSArray*) GetBookMarkArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
    
    for (HerbalMedicine *hmObject in hmArray)
    {
        if (hmObject.bookMakr)
        {
            [array addObject:hmObject];
        }
    }
    
    NSArray *bookMarkArray = [NSArray arrayWithArray:array];
    [array release];
    return bookMarkArray;
}

- (void)setBookMark:(NSInteger)unit forIndex:(NSInteger)index;
{
    HerbalMedicine *hmObject = [self objectAtUnit:unit forIndex:index];
    assert(hmObject);
    
    if (hmObject.bookMakr == TRUE)
    {
        return;
    }
    
    hmObject.bookMakr = TRUE;
    [self SaveBookMark];
}



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
        textSize = tsMiddle;
        
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
        
        [self LoadBookMark];
    }
    
    return self;
}

- (NSInteger)getTextFontSize
{
    switch (textSize) {
        case tsSmall:
            return 60;
            break;
        case tsMiddle:
            return 100;
            break;
        case tsBig:
            return 120;
            break;
        default:
            return 100;
            break;
    }
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
    if (index < 0 || index >= hmArray.count)
        return nil;
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
    //[hmArray removeAllObjects];
    //hmArray = [[NSMutableArray alloc] initWithArray:hmdb.hmArray];
	for (NSMutableArray *array in hmUnits)
	{
		[array removeAllObjects];
	}
	
	for (HerbalMedicine *hmObject in hmArray)
	{
		switch (hmObject.unit) 
		{
			case 1:
				[[hmUnits objectAtIndex: 0] addObject:hmObject];break;
			case 2:
				[[hmUnits objectAtIndex: 1] addObject:hmObject];break;
			case 3:
				[[hmUnits objectAtIndex: 2] addObject:hmObject];break;
			case 4:
				[[hmUnits objectAtIndex: 3] addObject:hmObject];break;
		}
	}

}

//搜索
- (void)Search:(NSString*)text
{
    if (text.length == 0)
    {
        [self Reset];
        return;
    }
    
    [hmUnits removeAllObjects];
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
