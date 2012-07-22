//
//  WebViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMDataBase.h"
#import "AdmobViewController.h"



@interface HMViewController : AdmobViewController
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

- (void)loadHtmlPage;

@end
