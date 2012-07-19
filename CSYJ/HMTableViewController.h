//
//  ViewController.h
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMViewController.h"


@interface HMTableViewController : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{
    
    HMViewController     *hmViewController;
}

@property (retain, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;

@property (retain, nonatomic) IBOutlet UITableView *table;

@property (retain, nonatomic) IBOutlet UISearchBar *search;

-(void) handleSearchForTerm:(NSString*)searchTerm;

@end
