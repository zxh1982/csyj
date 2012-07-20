//
//  ConfigViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"
#import "HMManager.h"
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
    
    switch ([indexPath row])
    {
        case 0:
        {
            // "Segmented" control to the right
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                    [NSArray arrayWithObjects:
                                                     [NSString stringWithString:@"简体"],
                                                     [NSString stringWithString:@"繁体"],
                                                     nil]];
            
            [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            segmentedControl.frame = CGRectMake(150 , 8, 150, 30);
            segmentedControl.selectedSegmentIndex = 1;
            segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered;
            //segmentedControl.momentary = YES;
            cell.textLabel.text = @"文字设置";
            [cell addSubview:segmentedControl];
            
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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

- (void)dealloc {
    [configTableView release];
    [super dealloc];
}
@end
