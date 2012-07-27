//
//  HMBookMarkViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HMBookMarkViewController.h"
#import "HMManager.h"
#import "HMViewController.h"
#import "ConvertJF.h"

@implementation HMBookMarkViewController

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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellBookMark";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    HerbalMedicine* hm = [bookMarkArray objectAtIndex: [indexPath row]];
    cell.textLabel.text = hm.caption;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMViewController *hmViewController = [[[HMViewController alloc]initWithNibName:@"HMViewController" bundle:nil] autorelease];
    hmViewController.unit = [indexPath section];
    hmViewController.index = [indexPath row];
    
    //检查webView是否创建
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        hmViewController.unit = -1;
        hmViewController.index = [indexPath row];
    }
    
    hmViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hmViewController animated:YES];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        HerbalMedicine* hmObject = [bookMarkArray objectAtIndex:[indexPath row]];
        hmObject.bookMakr = NO;
        [bookMarkArray removeObject:hmObject];
        [bookMarkTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade]; 
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if ( bookMarkArray != nil )
    {
        [bookMarkArray release];
        bookMarkArray = nil;
    }
    //bookMarkArray = [[NSMutableArray alloc] initWithArray:[[HMManager defaultManager] GetBookMarkArray]];
    bookMarkArray = [[HMManager defaultManager] GetBookMarkArray];
    [bookMarkArray retain];
    [bookMarkTable reloadData];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bookMarkArray.count;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.title = _S(@"我的书签");
    self.navigationItem.title = self.title;
}

- (void)viewDidUnload
{
    [bookMarkArray release];
    [bookMarkTable release];
    bookMarkTable = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [bookMarkTable release];
    [super dealloc];
}
@end
