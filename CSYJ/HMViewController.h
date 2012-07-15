//
//  WebViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMDataBase.h"

@interface HMViewController : UIViewController
{
    UIWebView *webView;
    NSString  *htmlTemplate;
    NSInteger unit;
    NSInteger index;
}


@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *htmlTemplate;
@property NSInteger unit;
@property NSInteger index;

@end
