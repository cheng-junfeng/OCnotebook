//
//  AppDelegate.h
//  ids
//
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign , nonatomic) BOOL isForceLandscape;
@property (assign , nonatomic) BOOL isForcePortrait;
@property (nonatomic, strong) BaseTabBarController  *baseTabBarController;

@end

