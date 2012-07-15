//
//  ViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMViewController.h"


@interface HMTableViewController : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate >
{
    
    IBOutlet UISearchBar *search;
    IBOutlet UITableView *table;
    HMViewController     *hmViewController;
}


-(void) handleSearchForTerm:(NSString*)searchTerm;

@end
