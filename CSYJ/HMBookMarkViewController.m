//
//  HMBookMarkViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HMBookMarkViewController.h"
#import "HMManager.h"
#import "bookMarkCell.h"
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
        
    BookMarkCell *cell = (BookMarkCell*)[tableView 
                                 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BookMarkCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
        
    HerbalMedicine* hm = [bookMarkArray objectAtIndex: [indexPath row]];
    cell.name.text = hm.caption;
    NSString *csyjDesc = [NSString stringWithFormat:@"长沙药解: %@", hm.description];
    cell.LabelText.text = _S(csyjDesc);
    
    if (hm.shennong.length != 0)
    {
        NSString *shennong = [NSString stringWithFormat:@"本经: %@", hm.shennong];
        cell.LabelShengLong.text = _S(shennong);
    }
    else
    {
        cell.LabelShengLong.hidden = YES;
    }
   
    
    NSString* picName = [NSString stringWithFormat:@"%@.png", hm.name];
    //通过名字获取图片文件路径
    NSString* fileName = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:picName];
    //检查文件是否存在
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    //存在才加载图片
    if (fileExist)
    {
        [cell.img setImage:[UIImage imageNamed:picName]]; 
    }

    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    if ( bookMarkArray != nil )
    {
        [bookMarkArray release];
        bookMarkArray = nil;
    }
    
    bookMarkArray = [[HMManager defaultManager] GetBookMarkArray];
    [bookMarkArray retain];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HerbalMedicine *hmObject = [bookMarkArray objectAtIndex:[indexPath row]];
    if (hmObject.shennong.length == 0)
    {
        return 120;
    }
    else
    {
        return 160;
    }
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

- (void)viewDidUnload
{
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
