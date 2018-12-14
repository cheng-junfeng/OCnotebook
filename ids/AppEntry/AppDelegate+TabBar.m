//
//  AppDelegate+TabBar.m
//  ZEBBaseProject
//
//  Created by zm4 on 2018/7/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "AppDelegate+TabBar.h"
#import "BaseTabBarController.h"
#import "BaseViewController.h"
#import "RootNavigationController.h"

@implementation AppDelegate (TabBar)

- (BaseTabBarController *)createViewControllers {
    
    BaseTabBarController *tabbar = [[BaseTabBarController alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Controllers" ofType:@"plist"];
    NSArray *plistArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *tabArray = [NSMutableArray array];
    
    for (NSDictionary *tabDict in plistArray) {
        Class class = NSClassFromString(tabDict[@"className"]);
        BaseViewController *listViewController = [[class alloc] init];
        RootNavigationController *listNavigation = [[RootNavigationController alloc] initWithRootViewController:listViewController];
        
        listViewController.title = tabDict[@"title"];
        listViewController.tabBarItem.image =[[UIImage imageNamed:tabDict[@"iconName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        listViewController.tabBarItem.selectedImage =[[UIImage imageNamed:tabDict[@"iconNameH"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [tabArray addObject:listNavigation];
    }
    
    tabbar.viewControllers = tabArray;
    
    return tabbar;
}

@end
