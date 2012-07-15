//
//  HMCell.m
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HMCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation HMCell
@synthesize name;
@synthesize description;
@synthesize thumbImage;

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
    CALayer* layer = [thumbImage layer];
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
    [name release];
    [description release];
    [thumbImage release];
    [super dealloc];
}
@end
