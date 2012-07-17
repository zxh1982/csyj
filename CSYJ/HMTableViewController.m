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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //取得数据库文件名
    self.title = @"长沙药解";
    
    [HMManager defaultManager].textType = ttTraditional;
    [super viewDidLoad];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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


-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击列表时解除searchBar的第一响应
    [search resignFirstResponder];
    return indexPath;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [[[NSMutableArray alloc]init]autorelease];

    NSString *title;
    for (int i = 0; i < [[HMManager defaultManager] UnitCount]; i++)
    {
        switch (i)
        {
            case 0: title = [NSString stringWithString:@"卷一"]; break;
            case 1: title = [NSString stringWithString:@"卷二"]; break;
            case 2: title = [NSString stringWithString:@"卷三"]; break;
            case 3: title = [NSString stringWithString:@"卷四"]; break;
            default: title = [NSString stringWithString:@""];
        }
        [array addObject: title];
    }
    return array;
}
 */

//显示药物详细内容
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //检查webView是否创建
    hmViewController = [[[HMViewController alloc]initWithNibName:@"HMViewController" bundle:nil] autorelease];
    //取得选择的对象
    hmViewController.unit = [indexPath section];
    hmViewController.index = [indexPath row];
    //使用presentModalViewController这个方法显示视图,在ipad上才能显示全
    [self.navigationController pushViewController:hmViewController animated:YES];
}

//分组相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = [[HMManager defaultManager] UnitCount];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[HMManager defaultManager] ItemsCountAtUnit:section];
    return count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
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

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[HMManager defaultManager] Search:searchText];
    [table reloadData];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [[HMManager defaultManager] Search:searchBar.text];
    [searchBar resignFirstResponder];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[HMManager defaultManager] Reset];
    [table reloadData];
    [searchBar resignFirstResponder];
}

- (void)viewDidUnload
{
    [table release];
    table = nil;
   
    [search release];
    search = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
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
