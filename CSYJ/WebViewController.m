//
//  WebViewController.m
//  CSYJ
//
//  Created by 晓衡 张 on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"
#import "ConvertJF.h"
#import "HMManager.h"

@implementation WebViewController

@synthesize webView;
@synthesize index;

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

//读取文件字符串,转换繁简
-(void)LoadHtmlFile:(NSString*)fileName
{
    //加载HTML模版字符串
    NSString *htmlFile =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
    NSString *html = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    float size = [[HMManager defaultManager] getTextFontSize];
    NSString *fontSize = [NSString stringWithFormat:@"font-size:%0.1fem;", size];
    html = [html stringByReplacingOccurrencesOfString:@"font-size:1em;" withString:fontSize];    
    NSAssert(html, @"read htmlFile error");
    
    NSURL *baseURL = [NSURL fileURLWithPath:htmlFile];
    
    //格式化HTML完整内容,加载页面
    [webView clearsContextBeforeDrawing];
    [webView loadHTMLString:html baseURL:baseURL];
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    self.bannerOrigin = CGPointMake(0, 44);

    if (index == 1)
    {
            }
    else
    {
        [navigationBar setHidden:TRUE];
        
        CGFloat width =  self.view.frame.size.width;
        UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
        [toolBar sizeToFit];
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;//这句作用是切换时宽度自适应.
        
        UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithTitle:_S(@"                   黄元御传") style:UIBarButtonItemStylePlain target:Nil action:Nil];
        [toolBar setItems:[NSArray arrayWithObject:barItem]];
        
        [self.view addSubview:toolBar];
        
        
        [toolBar release];
        
    //    [segMentControll setHidden:TRUE];
    //    navigationBar.backItem.title = self.title;
    //    [segMentControll setHidden:TRUE];
    //    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:Nil];
    //    navigationItem.title = self.title;
    //    [navigationBar pushNavigationItem:navigationItem animated:NO];
        //navigationItem.leftBarButtonItem = Nil;
    }
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    //加载HTML模版字符串
    switch (index)
    {
       case 1:
            [segMentControll setTitle:_S(@"自叙") forSegmentAtIndex:0];
            [segMentControll setTitle:_S(@"后序") forSegmentAtIndex:1];
            [self segmentValueChanged:segMentControll];
            break;
        case 2:
        {
            NSString *htmlFileName =  [HMManager defaultManager].textType == ttSimplified ? @"csyj_hyy.html" : @"csyj_hyy(t).html";
            CGRect rect = [webView frame];
            rect.size.height += navigationBar.frame.size.height;
            rect.origin.y = 0;
            webView.frame = rect;
           
            [self LoadHtmlFile: htmlFileName];
        }
            break;
    }    
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [webView release];
    webView = nil;
    [navigationBar release];
    navigationBar = nil;
    [segMentControll release];
    segMentControll = nil;
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

    [webView release];
    [webView release];
    [navigationBar release];
    [segMentControll release];
    [super dealloc];
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender;
{
    NSString *htmlFileName = sender.selectedSegmentIndex == 0 ? 
                             @"csyj_zx.html" : 
                             @"csyj_hx.html";
    [self LoadHtmlFile: htmlFileName];    
   
}
@end
