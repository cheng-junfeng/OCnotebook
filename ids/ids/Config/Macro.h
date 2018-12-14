//
//  Macro.h
//  ZEBBaseProject
//
//  Created by zm4 on 2018/7/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define KFont(font) [UIFont systemFontOfSize:font]


#define kNavigationHeight 44

#define HOME_SIZE 12

//二维码扫描库
#define LBXScan_Define_Native  //包含native库
#define LBXScan_Define_ZXing   //包含ZXing库
#define LBXScan_Define_UI     //包含界面库
/*! token */
#define WS_Token    @"token"
/*! url_schemes */
#define URL_SCHEMES  @"SMART"
/*! 配置文件IP */
#define WSServerIP  @"WSServerIP"

/*! 请求拼接的URL */
#define WSEhswebapiHttps_Url(url)  [NSString stringWithFormat:@"%@%@",[[WSServerConfig sharedServerConfig] getehswebapi],url]
#define WSSsoHostHttps_Url(url)  [NSString stringWithFormat:@"%@%@",[[WSServerConfig sharedServerConfig] getssoHost],url]
#define WSHttps_Url(url)  [NSString stringWithFormat:@"%@%@",[[WSServerConfig sharedServerConfig] getwesafeAppdroid],url]

/*! 界面跳转拼接URL */
#define WSPush_Url(vc)  [NSString stringWithFormat:@"SMART://PushViewController/%@",vc]

//NSUserDefault缓存
#define WSUserDefaultsSet(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define WSUserDefaultsSetBool(value,key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define WSUserDefaultsGet(key) [[NSUserDefaults standardUserDefaults] objectForKey:key];
#define WSUserDefaultsGetBool(key) [[NSUserDefaults standardUserDefaults] boolForKey:key];
#define WSUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]

/*! title截取 */
#define Empty(modelTitle)   modelTitle ? modelTitle : @"未知";
#define Nav_SubTitle(modelTitle)   NSString *title = modelTitle ? modelTitle : @"未知";\
title = title.length > 10 ? [NSString stringWithFormat:@"%@...",[title substringWithRange:NSMakeRange(0, 10)]] : title

//获取导航栏+状态栏的高度
#define getRectNavAndStatusHight  (self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)
//状态栏高度
#define getStatusBarHight     [[UIApplication sharedApplication] statusBarFrame].size.height

/*! 服务器返回数据成功code */
#define WS_SuccessCode  200
/*! 加载提示语 */
#define LoadingAlert    @"正在加载..."
#define LoadingConfirm  @"正在提交..."
/*! 网络请求一页的数量 */
#define httpsLimit  @"20"

/*! 通知History重新加载数据 */
#define kHistoryControllerloadDataNotification     @"historyControllerloadDataNotification"

//判断是否是iphonex
static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}
#endif /* Macro_h */
