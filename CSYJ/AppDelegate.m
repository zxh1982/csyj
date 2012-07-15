
//
//  AppDelegate.m
//  CSYJ
//
//  Created by 晓衡 张 on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "WebViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize navController;
@synthesize tabBarController = _tabBarController;


- (void)dealloc
{
    [navController release];
    [window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    _tabBarController = [[UITabBarController alloc]init];
    
    NSMutableArray *viewArray = [[[NSMutableArray alloc]init] autorelease];
    
    [viewArray addObject:self.navController];
    
    WebViewController *viewController1 = [[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil] autorelease];
    viewController1.title = @"长沙药解•序";
    viewController1.index = 1;
    WebViewController *viewController2 = [[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil]autorelease];
    viewController2.title = @"黄元御传";
    viewController2.index = 2;
    [viewArray addObject:viewController1];
    [viewArray addObject:viewController2];
    
    _tabBarController.viewControllers = viewArray;

    
    [self.window addSubview:_tabBarController.view];
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
