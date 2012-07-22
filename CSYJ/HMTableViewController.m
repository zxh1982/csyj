//
//  ViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HMTableViewController.h"
#import "HMCell.h"
#import "WebViewController.h"
#import "HMManager.h"
#import "ConvertJF.h"


@implementation HMTableViewController

@synthesize searchDisplayController;
@synthesize search;
@synthesize table;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //取得数据库文件名
    self.title = _S(@"长沙药解");
    [super viewDidLoad];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) 
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView 
                                 dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] 
                     initWithStyle:UITableViewCellStyleDefault 
                     reuseIdentifier:CellIdentifier] autorelease];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        HerbalMedicine* hm = [[HMManager defaultManager] objectAtIndex: [indexPath row]];
        cell.textLabel.text = hm.caption;
        return cell;
    }
    else
    {
        static NSString* cellIdentifier = @"HMCell";
        HMCell* cell = (HMCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HMCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        //创建HMCell对象,并设置药物名字\描述\图片
        NSInteger section = [indexPath section];
        NSInteger row = [indexPath row];
        HerbalMedicine* hm = [[HMManager defaultManager] objectAtUnit:section forIndex:row];
        
        cell.name.text = hm.caption;
        cell.description.text = hm.description;
        
        NSString* picName = [NSString stringWithFormat:@"%@.png", hm.name];
        
        //通过名字获取图片文件路径
        NSString* fileName = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:picName];
        //检查文件是否存在
        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
        //存在才加载图片
        if (fileExist)
        {
            [cell.thumbImage setImage:[UIImage imageNamed:picName]]; 
        }
        return cell;
    }
  
}


-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击列表时解除searchBar的第一响应
    [search resignFirstResponder];
    return indexPath;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return 40;
    }
    else
    {
        return 60;
    }
}

//显示药物详细内容
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    hmViewController = [[[HMViewController alloc]initWithNibName:@"HMViewController" bundle:nil] autorelease];
    hmViewController.unit = [indexPath section];
    hmViewController.index = [indexPath row];

    //检查webView是否创建
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        hmViewController.unit = -1;
        hmViewController.index = [indexPath row];
    }
    
    
    [self.navigationController pushViewController:hmViewController animated:YES];
}



//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{
   
//}

//分组相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return  1;
    }
    else
    {
        NSInteger count = [[HMManager defaultManager] UnitCount];
        return count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        rows = [[HMManager defaultManager] ItemsCount];
    }
    else
    {
        rows = [[HMManager defaultManager] ItemsCountAtUnit:section];
    }
    return rows;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return nil;
    }
    
    NSString *title;
    switch (section)
    {
        case 0: title = [NSString stringWithString:@"卷一"]; break;
        case 1: title = [NSString stringWithString:@"卷二"]; break;
        case 2: title = [NSString stringWithString:@"卷三"]; break;
        case 3: title = [NSString stringWithString:@"卷四"]; break;
        default: title = [NSString stringWithString:@""];
    }
    return title;
}

//搜索相关

-(void)reloadData
{
    [[HMManager defaultManager] Reset];
}

- (void)filterContentForSearchText:(NSString*)searchText 
                             scope:(NSString*)scope
{
    //NSPredicate *resultPredicate = [NSPredicate 
    //                                predicateWithFormat:@"SELF like %@",
    //                                searchText];
    
    [[HMManager defaultManager] Search:searchText];
    //self.searchResults = [self.allItems filteredArrayUsingPredicate:resultPredicate];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                       objectAtIndex:searchOption]];
    
    return YES;
}

//-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [[HMManager defaultManager] Search:searchBar.text];
//    [searchBar resignFirstResponder];
//}

//-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    searchBar.text = @"";
//    [[HMManager defaultManager] Reset];
//    [table reloadData];
//    [searchBar resignFirstResponder];
//}

- (void)viewDidUnload
{
    [searchDisplayController release];
    searchDisplayController = nil;
    
    [search release];
    search = nil;
    
    [table release];
    table = nil;
    
    [super viewDidUnload];
}

-(void)dealloc
{
    [search release];
    [search release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [table reloadData];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
