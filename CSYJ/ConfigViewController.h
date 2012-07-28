//
//  ConfigViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SETTINGS_FILE @"settings.plist"

@interface ConfigViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UISegmentedControl *segText;
    UISegmentedControl *segFontSize;
    UISegmentedControl *segShowName; //是否显示药物名称
    
    NSString *settingsFile;
}

- (NSString*)settingsFile;


@property (retain, nonatomic) IBOutlet UITableView *configTableView;

@end
