//
//  HMBookMarkViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBookMarkViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *bookMarkArray;
    IBOutlet UITableView *bookMarkTable;
}
@end
