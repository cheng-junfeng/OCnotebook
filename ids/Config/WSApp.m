//
//  WSApp.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/2.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "WSApp.h"
#import <IQKeyboardManager.h>

@implementation WSApp

+ (WSApp*)startApp
{
    __strong static id _sharedObject = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (_sharedObject == nil) {
            _sharedObject = [[self alloc] init];
        }
    }
    return _sharedObject;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initall];
    }
    return self;
}

- (void)initall {
    [self initApp];
    [self initNavigationBar];
    [self initIQKeyboardManager];
    [self netWorkChangeEvent];
}
//初始化导航栏
- (void)initNavigationBar {
    
    //将返回按钮title 文字的颜色改为透明
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100,0) forBarMetrics:UIBarMetricsDefault];
    }else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    }
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(20, 124, 228)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UITabBar appearance] setTintColor:RGBCOLOR(22, 133, 245)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
- (void)initApp {
    
    [self sdWebImageDownloaderAddHeaderField];

}
/*! SDWebImageDownloader添加请求头 */
- (void)sdWebImageDownloaderAddHeaderField {
    //SDWebImageDownloader添加请求头
    SDWebImageDownloader *manager = [SDWebImageManager sharedManager].imageDownloader;
    // 将token添加到请求头
    NSString *token = WSUserDefaultsGet(WS_Token);
    if (token) { //本地有token添加到请求头
        [manager setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    }
}
- (void)initIQKeyboardManager {
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:15]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
}
#pragma mark - 检测网络状态变化
-(void)netWorkChangeEvent {
    
    [HttpsManager AFNetworkStatus:^(AFNetworkReachabilityStatus status) {
        UIViewController *currentVC = [WSPageManager getCurrentVC];
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                [currentVC showHint:@"当前无网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前无网络");
                [currentVC showHint:@"当前无网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkChangeEventNotification" object:@(status)];
    }];
}
@end
