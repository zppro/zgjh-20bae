//
//  EAB2AppDelegate.m
//  eab20
//
//  Created by zppro on 13-12-11.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "EAB2AppDelegate.h"
#import "AppMacro.h"
#import "HomeController.h"
#import "TSInfiniteScrollViewController.h"

@implementation EAB2AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initSettings];
    
    [AppSession readSettings];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor blackColor];
    
    HomeController *homeController = [[[HomeController alloc] init] autorelease];
    MWFSlideNavigationViewController * slideNavCtl = [[MWFSlideNavigationViewController alloc] initWithRootViewController:homeController];
    slideNavCtl.panEnabled = YES;
    //TSInfiniteScrollViewController *homeController = [[[TSInfiniteScrollViewController alloc] init] autorelease];
    //[_window setRootViewController:[[[UINavigationController alloc] initWithRootViewController:homeController] autorelease]];
    self.window.rootViewController = slideNavCtl;
    [slideNavCtl release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}

//系统第一次运行时，初始化参数
-(void)initSettings {
    //MARK;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //是否激活
    if (![defaults objectForKey:APP_SETTING_IS_ACTIVIATED_KEY]) {
        [NSUserDefaults setBool:FALSE forKey:APP_SETTING_IS_ACTIVIATED_KEY];
    } 
    
    //认证地址
    if (![defaults objectForKey:APP_SETTING_ACTIVIATE_BASE_URL_KEY]) {
        [NSUserDefaults setString:@"42.120.6.22:8889"  forKey:APP_SETTING_ACTIVIATE_BASE_URL_KEY];
    }
    
    //认证地址
    if (![defaults objectForKey:APP_SETTING_AUTH_BASE_URL_KEY]) {
        [NSUserDefaults setString:@"42.120.6.22:8889"  forKey:APP_SETTING_AUTH_BASE_URL_KEY];
    }
    
    //认证类型
    if (![defaults objectForKey:APP_SETTING_AUTHENENTICATION_INTERFACE_TYPE_KEY]) {
        [NSUserDefaults setInt:0 forKey:APP_SETTING_AUTHENENTICATION_INTERFACE_TYPE_KEY];
    }
    
    //Debug Mode
    if (![defaults objectForKey:SETTING_DEBUG_KEY]) {
        [NSUserDefaults setBool:FALSE forKey:SETTING_DEBUG_KEY];
    }
    //设置版本
    [NSUserDefaults setString:[[NSBundle mainBundle] bundleVersion]  forKey:SETTING_DEPLOY_VERSION_KEY];
    [defaults synchronize];
}

@end
