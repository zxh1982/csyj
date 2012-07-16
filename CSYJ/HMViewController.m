//
//  WebViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HMViewController.h"
#include "HMManager.h"

@implementation HMViewController
@synthesize webView;
@synthesize htmlTemplate;

@synthesize unit;
@synthesize index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
   	// "Segmented" control to the right
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"up.png"],
                                             [UIImage imageNamed:@"down.png"],
                                             nil]];
    
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 90, 30);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	
	//defaultTintColor = [segmentedControl.tintColor retain];	// keep track of this for later
    
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    [segmentedControl release];
    
	self.navigationItem.rightBarButtonItem = segmentBarItem;
    
    //加载HTML模版字符串
    NSString *htmlFile =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"template.html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    self.htmlTemplate = html;
    
    NSAssert(htmlFile, @"read htmlFile error");
    return self;
}

- (IBAction)segmentAction:(UISegmentedControl *)sender
{
	// The segmented control was clicked, handle it here 
	//UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	//NSLog(@"Segment clicked: %d", segmentedControl.selectedSegmentIndex);
	NSInteger index = sender.selectedSegmentIndex;
	if (index == 0)
	{
	}
	else
	{
	}

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
    
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com.hk"]]];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    //格式化药物文本,替换'\'为<p>
    HerbalMedicine* hm = [[HMManager defaultManager] objectAtUnit:unit forIndex:index];
    NSString *classicUse = [[NSString stringWithFormat:hm.classicUse] stringByReplacingOccurrencesOfString: @"\n" withString:@"<p>"];
    NSString *summary = [[NSString stringWithFormat:hm.summary] stringByReplacingOccurrencesOfString:@"\n" withString:@"<p>"];
    
    //格式化HTML完整内容,加载页面
    NSString *htmlString = [NSString stringWithFormat: self.htmlTemplate, hm.name, hm.name, @"本经", hm.shennong, hm.description, classicUse, summary];
    [webView loadHTMLString:htmlString baseURL:baseURL];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [webView clearsContextBeforeDrawing];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
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
    [htmlTemplate release];
    [webView release];
    [super dealloc];
}

@end
