//
//  AdmobViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#define MY_BANNER_UNIT_ID @"a150095b00b5645" 

@interface AdmobViewController : UIViewController
{
    GADBannerView *bannerView_;
}

@property (assign,nonatomic) CGPoint bannerOrigin;
@end
