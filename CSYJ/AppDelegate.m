
//
//  AppDelegate.m
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "WebViewController.h"
#import "HMTableViewController.h"
#import "ConfigViewController.h"
#import "HMManager.h"
#import "ConvertJF.h"
#import "HMBookMarkViewController.h"
@implementation AppDelegate

@synthesize window;
@synthesize navController;
@synthesize tabBarController;


- (void)dealloc
{
    [navController release];
    [window release];
    [tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //[HMManager defaultManager].textType = ttTraditional;

    HMTableViewController *hmTableViewController = [[[HMTableViewController alloc]initWithNibName:@"HMTableViewController" bundle:nil] autorelease];
    
    hmTableViewController.title = _S(@"长沙药解");
    [self.navController pushViewController:hmTableViewController animated:TRUE];
    //[viewArray addObject:self.navController];
    
    
    WebViewController *viewController1 = [[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil] autorelease];
    //viewController1.title = _S(@"长沙药解•序");
    viewController1.index = 1;
    viewController1.tabBarItem = [[[UITabBarItem alloc] initWithTitle:_S(@"长沙药解•序") image:[UIImage imageNamed:@"xu.png"] tag:0] autorelease];

    
    WebViewController *viewController2 = [[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil]autorelease];
    //viewController2.title = _S(@"黄元御传");
    viewController2.index = 2;
      viewController2.tabBarItem = [[[UITabBarItem alloc] initWithTitle:_S(@"黄元御传") image:[UIImage imageNamed:@"hyy.png"] tag:0] autorelease];
    
    
    HMBookMarkViewController *bookMarkViewController = [[[HMBookMarkViewController alloc]initWithNibName:@"HMBookMarkViewController" bundle:nil]autorelease];
    
    //bookMarkViewController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:_S(@"我的书签") image:[UIImage imageNamed:@"setting.png"] tag:0] autorelease];
    
    UINavigationController *bookMarkNav = [[[UINavigationController alloc] init] autorelease];
    [bookMarkNav pushViewController:bookMarkViewController animated:TRUE];
   

    
    ConfigViewController *configViewController = [[[ConfigViewController alloc]initWithNibName:@"ConfigViewController" bundle:nil]autorelease];
    configViewController.title = _S(@"设置");
    //[viewArray addObject:viewController1];
    //[viewArray addObject:viewController2];
    
    NSArray *arrayViewController = [NSArray arrayWithObjects:
                                    self.navController,
                                    viewController1,
                                    viewController2,
                                    bookMarkNav,
                                    configViewController,
                                    nil];
    
    tabBarController.viewControllers = arrayViewController;
    

    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
