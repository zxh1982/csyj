//
//  WebViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WebViewController : UIViewController
{
    int index;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property int index;

@end
