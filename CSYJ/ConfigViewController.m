//
//  ConfigViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"
#import "HMManager.h"
#import "ConvertJF.h"

@implementation ConfigViewController
@synthesize configTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //HMManager* hm = [HMManager defaultManager];
    //segText.selectedSegmentIndex = hm.textType;
    //segFontSize.selectedSegmentIndex = hm.textSize;
}

- (void)viewWillAppear:(BOOL)animated
{
    [configTableView reloadData];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch ([indexPath section])
    {
        //文件设置
        case 0:
        {
            // "Segmented" control to the right
            segText = [[UISegmentedControl alloc] initWithItems:
                                                    [NSArray arrayWithObjects:
                                                     [NSString stringWithString:@"简体"],
                                                     [NSString stringWithString:_S(@"繁体")],
                                                     nil]];
            
            segText.frame = CGRectMake(150 , 8, 150, 30);
            segText.selectedSegmentIndex = [HMManager defaultManager].textType;
            segText.segmentedControlStyle = UISegmentedControlStyleBar;
            //segmentedControl.momentary = YES;
            cell.textLabel.text = _S(@"文字设置");
            [cell addSubview:segText];
            //[segmentedControl release];
        }
        break;
            
        case 1:
        {
            segFontSize = [[UISegmentedControl alloc] initWithItems:
                       [NSArray arrayWithObjects:
                        [NSString stringWithString:_S(@"小号")],
                        [NSString stringWithString:_S(@"中号")],
                        [NSString stringWithString:_S(@"大号")],
                        nil]];
            
            segFontSize.frame = CGRectMake(150 , 8, 150, 30);
            segFontSize.selectedSegmentIndex = [HMManager defaultManager].textSize;
            segFontSize.segmentedControlStyle = UISegmentedControlStyleBar;
            //segmentedControl.momentary = YES;
            cell.textLabel.text = _S(@"字体设置");
            [cell addSubview:segFontSize];

        }
        default:
            break;
    }
    
    return cell;
}

//分组相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//更新tabbar的繁简文字
-(void)UpdateTabBarTitle
{
    
    UIViewController *c1 = [[self.tabBarController viewControllers] objectAtIndex:0];
    c1.title = _S(@"长沙药解");
    
    UIViewController *c2 = [[self.tabBarController viewControllers] objectAtIndex:1];
    c2.title = _S(@"长沙药解•序");
    
    UIViewController *c3 = [[self.tabBarController viewControllers] objectAtIndex:2];
    c3.title = _S(@"黄元御传");
    
    UIViewController *c4 = [[self.tabBarController viewControllers] objectAtIndex:3];
    c4.title = _S(@"我的书签");
    
    UIViewController *c5 = [[self.tabBarController viewControllers] objectAtIndex:4];
    c5.title = _S(@"设置");
}


- (IBAction)segmentAction:(UISegmentedControl *)sender
{
    [HMManager defaultManager].textType = (TEXT_TYPE)[sender selectedSegmentIndex];
}

- (void)viewDidUnload
{
    [self setConfigTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewWillDisappear:(BOOL)animated
{
    //更新界面文件字
    TEXT_TYPE textType = [segText selectedSegmentIndex];
    if ([HMManager defaultManager].textType != textType) 
    {
        [HMManager defaultManager].textType = textType;
        [self UpdateTabBarTitle];
    }
    
    [HMManager defaultManager].textSize = segFontSize.selectedSegmentIndex; 
}

- (void)dealloc {
    [segText release];
    [configTableView release];
    [super dealloc];
}

@end
