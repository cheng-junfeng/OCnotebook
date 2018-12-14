//
//  AppDelegate+We.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/10/11.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "AppDelegate+We.h"
#import "AppDelegate+TabBar.h"
#import "AppDelegate+JLRouter.h"
#import "WSApp.h"
#import "WSRealmHelper.h"

@implementation AppDelegate (We)

- (void)weApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WSApp startApp];
    [self addRouter];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [WSRealmHelper refreshRealm];
    
    [WSPageManager enterMainUI];
}
@end
