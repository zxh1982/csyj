//
//  ConfigViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UISegmentedControl *segText;
    UISegmentedControl *segFontSize;
}




@property (retain, nonatomic) IBOutlet UITableView *configTableView;

@end
