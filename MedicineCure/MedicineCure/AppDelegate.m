//
//  AppDelegate.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AppDelegate.h"

#import "ICSDrawerController.h"
#import "BaseNavigationController.h"
#import "HomePageViewController.h"
#import "LeftViewController.h"
#import "UserLoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)preAppLoad:(NSDictionary *)launchOptions
{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self preAppLoad:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    self.window.layer.cornerRadius = 3;
    self.window.clipsToBounds = YES;
    
    [self initTheAppFunction];
    
    return YES;
}

- (void)initTheAppFunction
{
    [self initUMInfo];
    
    HomePageViewController *home = [HomePageViewController new];
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:home];
    
    LeftViewController *left = [LeftViewController new];
    ICSDrawerController *draw = [[ICSDrawerController alloc] initWithLeftViewController:left centerViewController:navi];
    home.drawer = draw;
    
    self.window.rootViewController = draw;
    
    if (![UserDefaultControl shareInstance].cacheLoginedUserEntity) {
        BaseNavigationController *loginNavi = [[BaseNavigationController alloc] initWithRootViewController:[UserLoginVC new]];
        [draw presentViewController:loginNavi animated:YES completion:nil];
    }
}

- (void)initUMInfo
{
    [MobClick setAppVersion:XcodeAppVersion];

    [MobClick startWithAppkey:kUmengKey];
    
    [MobClick updateOnlineConfig];
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
