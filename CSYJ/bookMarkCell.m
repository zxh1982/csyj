//
//  bookMarkCell.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "bookMarkCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation BookMarkCell
@synthesize name;
@synthesize img;
@synthesize LabelText;
@synthesize LabelShengLong;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    CALayer* layer = [img layer];
        //[layer setMaskToBounds:YES];
        //UIColor* color = [UIColor colorWithRed:0.95 green:0.95 blue:0];    [layer setBackgroundColor:color];
    layer.masksToBounds = TRUE;
    [layer setCornerRadius:12.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
        
    [super setSelected:selected animated:animated];
        // Configure the view for the selected state
   
}

- (void)dealloc {
    [img release];
    [LabelText release];
    [LabelShengLong release];
    [name release];
    [super dealloc];
}
@end
