//
//  WebViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdmobViewController.h"


@interface WebViewController : AdmobViewController
{
    int index;
    IBOutlet UIWebView *webView;
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UISegmentedControl *segMentControll;
}


- (IBAction)segmentValueChanged:(UISegmentedControl *)sender;
@property (assign, nonatomic) int index;
@property (retain, nonatomic) UIWebView *webView;


@end
