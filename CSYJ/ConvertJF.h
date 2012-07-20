//
//  ConvertJF.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _S(str) [[ConvertJF getInstance] convert:(str)]

@interface ConvertJF : NSObject
{
    NSMutableDictionary *dict;
}

+ (ConvertJF *)getInstance;
- (NSString *)convert:(NSString*)text;

@end
