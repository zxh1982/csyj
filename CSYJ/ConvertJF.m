//
//  ConvertJF.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConvertJF.h"

@implementation ConvertJF


+ (ConvertJF *)getInstance
{
    static ConvertJF *instance;
    
    if (instance == nil)
    {
        if (instance == NULL)
        {
            instance = [[ConvertJF alloc]init];
        }
    }
    
    return instance;
}

- (ConvertJF *)init
{
    self = [super init];
    
    //加载字典文件
    NSString *dictFile =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Dictionary.txt"];
    NSString *dictString = [NSString stringWithContentsOfFile:dictFile encoding:NSUTF8StringEncoding error:nil];
    NSArray  *dictArray = [dictString componentsSeparatedByString:@"\n"];
    
    dict = [[NSMutableDictionary alloc] init];
	for (NSString *str in dictArray)
	{
        NSString *key = [str substringWithRange:NSMakeRange(0, 1)];
        NSString *value = [str substringWithRange:NSMakeRange(1,1)];
        [dict setObject:value forKey: key];
	}
    return self;
}

- (NSString *)convert:(NSString*)text
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
	
	return text;
}

@end
