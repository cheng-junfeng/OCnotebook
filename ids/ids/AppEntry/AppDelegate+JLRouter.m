//
//  AppDelegate+JLRouter.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/9/7.
//  Copyright © 2018年 zm4. All rights reserved.
//  注册路由

#import "AppDelegate+JLRouter.h"
#import <objc/runtime.h>
#import "DXAlertView.h"

/*! 弹框 只包含确定按钮 */
#define Router_AlertView    @"/DXAlertView"
/*!  跳转指定界面 */
#define Router_PushViewController    @"/PushViewController/:controller"

@implementation AppDelegate (JLRouter)

/*! 注册路由 */
- (void)addRouter {
    
    [JLRoutes setVerboseLoggingEnabled:YES];
    
    /*! 弹框 */
    [[JLRoutes globalRoutes] addRoute:Router_AlertView handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        NSString *message = parameters[@"message"];
        NSString *title = parameters[@"title"]; // ch add
        if (title==nil) {
            DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"提示" message:message cancelBtnTitle:nil otherBtnTitle:@"确定"];
            [alertView show];
        }else{
            DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:title message:message cancelBtnTitle:nil otherBtnTitle:@"确定"];
            [alertView show];
        }
        return YES;
    }];
    
    //跳转指定界面
    [[JLRoutes globalRoutes] addRoute:Router_PushViewController handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        NSString *controller = parameters[@"controller"];
        UIViewController *currentVc = [self currentViewController];
        NSString *title = parameters[@"title"];
        UIViewController *vc = [[NSClassFromString(controller) alloc] init];
        [self paramToVc:vc param:parameters];
        vc.hidesBottomBarWhenPushed = YES;
        if (title) {
            vc.title = parameters[@"title"];
        }
        [currentVc.navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    
}
/*! 获取当前控制器 */
- (UIViewController *)currentViewController {
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
/*! runtime 赋值 */
- (void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters {
    //runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

// iOS 9.0前方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme: %@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    
    // 从浏览器打开时候会自动全部转成小写，而从应用内调用的话大小写不会变化
    // 为了方便判断所以统一转成小写来判断
    
    NSString *urlSchemeStr = [[url scheme] lowercaseString]; // url scheme 转换为小写的字符串
    NSLog(@"urlSchemeStr: %@",urlSchemeStr);
    
    if ([urlSchemeStr isEqualToString:@"we"]) {
        
        return [[JLRoutes routesForScheme:@"WE"] routeURL:url];
    }
    
    return YES;
}

// iOS 9.0后方法
- (BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
   
    NSLog(@"options: %@", options);
    
    NSLog(@"Calling Application Bundle ID: %@", [options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"]);
    
    NSLog(@"URL scheme: %@", [url scheme]);
    NSLog(@"URL  host : %@", [url host]);
    NSLog(@"URL  query: %@", [url query]);
    
    // 从浏览器打开时候会自动全部转成小写，而从应用内调用的话大小写不会变化
    // 为了方便判断所以统一转成小写来判断
    
    NSString *urlSchemeStr = [[url scheme] lowercaseString]; // url scheme 转换为小写的字符串
    NSLog(@"urlSchemeStr: %@",urlSchemeStr);
    
    if ([urlSchemeStr isEqualToString:@"we"]) {
        return [JLRoutes routeURL:url];
    }
    return YES;
}
@end
