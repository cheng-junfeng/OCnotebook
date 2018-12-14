//
//  HttpsManager.m
//  ProjectTemplate
//
//  Created by -- on 16/7/17.
//  Copyright © 2016年 Jomper Studio. All rights reserved.
//

#import "HttpsManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation HttpsManager


#pragma mark - 创建HttpsManager单例对象
+ (nonnull HttpsManager *)sharedManager {
    
    static HttpsManager *manager = nil;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        manager = [self new];
    });
    return manager;
}

#pragma mark - getter
- (AFHTTPSessionManager *)httpSessionManager
{
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        // 超时时间
        _httpSessionManager.requestSerializer.timeoutInterval = 30.f;
        
        // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
        // 上传普通格式s。
        //JSON AFJSONResponseSerializer
        _httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        // 声明获取到的数据格式
        // AFN不会解析,数据是data，需要自己解析
        _httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_httpSessionManager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest *_Nonnull (NSURLSession *_Nonnull session,
                  NSURLSessionTask * _Nonnull task,
                  NSURLResponse * _Nonnull response,
                  NSURLRequest * _Nonnull request) {
            return nil;
        }];

    }
    
    return _httpSessionManager;
}
- (AFHTTPSessionManager *)httpJSONSessionManager
{
    if (!_httpJSONSessionManager) {
        _httpJSONSessionManager = [AFHTTPSessionManager manager];
        // 超时时间
        _httpJSONSessionManager.requestSerializer.timeoutInterval = 30.f;
        
        // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
        // 上传普通格式s。
        //JSON AFJSONResponseSerializer
        _httpJSONSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // 声明获取到的数据格式
        // AFN不会解析,数据是data，需要自己解析
        _httpJSONSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_httpJSONSessionManager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest *_Nonnull (NSURLSession *_Nonnull session,
                                                                                             NSURLSessionTask * _Nonnull task,
                                                                                             NSURLResponse * _Nonnull response,
                                                                                             NSURLRequest * _Nonnull request) {
            return nil;
        }];
    }
    
    return _httpJSONSessionManager;
}
- (AFHTTPSessionManager *)httpLoginSessionManager
{
    if (!_httpLoginSessionManager) {
        _httpLoginSessionManager = [AFHTTPSessionManager manager];
        // 超时时间
        _httpLoginSessionManager.requestSerializer.timeoutInterval = 30.f;
        
        // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
        // 上传普通格式s。
        //JSON AFJSONResponseSerializer
        _httpLoginSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        // 声明获取到的数据格式
        // AFN不会解析,数据是data，需要自己解析
        _httpLoginSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_httpLoginSessionManager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest *_Nonnull (NSURLSession *_Nonnull session,
                                                                                             NSURLSessionTask * _Nonnull task,
                                                                                             NSURLResponse * _Nonnull response,
                                                                                             NSURLRequest * _Nonnull request) {
            return nil;
        }];
        
    }
    
    return _httpLoginSessionManager;
}
#pragma mark - Public Method
- (void)get:(NSString *)urlString parameters:(NSDictionary *)param progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable response))successBlock failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock
{
    // 将token添加到请求头
    NSString *token = WSUserDefaultsGet(WS_Token);
    if (token) { //本地有token添加到请求头
       [self.httpSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        NSLog(@"header:%@",[NSString stringWithFormat:@"Bearer %@",token]);
    }else {
        [self.httpSessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"url:%@",urlString);
    [self.httpSessionManager GET:urlString parameters:param progress:^(NSProgress * _Nonnull progress) {
        // 这里可以获取到目前数据请求的进度
        progressBlock(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"数据是：%@",jsonDic);
        if (jsonDic) {
           successBlock(task, jsonDic);
        }else {
            successBlock(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        failureBlock(task, error);
    }];
}
- (void)getJSON:(NSString *)urlString parameters:(NSDictionary *)param progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable response))successBlock failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock
{
    // 将token添加到请求头
    NSString *token = WSUserDefaultsGet(WS_Token);
    if (token) { //本地有token添加到请求头
        [self.httpJSONSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        NSLog(@"header:%@",[NSString stringWithFormat:@"Bearer %@",token]);
    }else {
        [self.httpJSONSessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"url:%@",urlString);
    [self.httpJSONSessionManager GET:urlString parameters:param progress:^(NSProgress * _Nonnull progress) {
        // 这里可以获取到目前数据请求的进度
        progressBlock(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"数据是：%@",jsonDic);
        successBlock(task, jsonDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        failureBlock(task, error);
    }];
}
- (void)post:(NSString *)urlString parameters:(NSDictionary *)param progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable reponse))successBlock failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock
{
    // 将token添加到请求头
    NSString *token = WSUserDefaultsGet(WS_Token);
    if (token) { //本地有token添加到请求头
        [self.httpSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        NSLog(@"header:%@",[NSString stringWithFormat:@"Bearer %@",token]);
    }else {
        [self.httpSessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"url:%@",urlString);
    [self.httpSessionManager POST:urlString parameters:param
         progress:^(NSProgress * _Nonnull progress) {
             // 这里可以获取到目前数据请求的进度
             progressBlock(progress);
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // 请求成功
             NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"数据是：%@",jsonDic);
             successBlock(task, jsonDic);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             // 请求失败
             failureBlock(task, error);
         }];
    
}
- (void)loginPost:(NSString *)urlString parameters:(NSDictionary *)param progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable reponse))successBlock failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock
{
    NSLog(@"url:%@",urlString);
    [self.httpLoginSessionManager POST:urlString parameters:param
                         progress:^(NSProgress * _Nonnull progress) {
                             // 这里可以获取到目前数据请求的进度
                             progressBlock(progress);
                         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             // 请求成功
                             NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                             NSLog(@"数据是：%@",jsonDic);
                             successBlock(task, jsonDic);
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             // 请求失败
                             failureBlock(task, error);
                         }];
    
}
- (NSURLSessionDataTask *)postJSON:(NSString *)urlString parameters:(NSDictionary *)param progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable reponse))successBlock failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock
{
    // 将token添加到请求头
    NSString *token = WSUserDefaultsGet(WS_Token);
    if (token) { //本地有token添加到请求头
        [self.httpJSONSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        NSLog(@"header:%@",[NSString stringWithFormat:@"Bearer %@",token]);
    }else {
        [self.httpJSONSessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"url:%@",urlString);
    NSURLSessionDataTask *task = [self.httpJSONSessionManager POST:urlString parameters:param
                         progress:^(NSProgress * _Nonnull progress) {
                             // 这里可以获取到目前数据请求的进度
                             progressBlock(progress);
                         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             // 请求成功
                             NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                             NSLog(@"数据是：%@",jsonDic);
                             successBlock(task, jsonDic);
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             // 请求失败
                             failureBlock(task, error);
                         }];
    return task;
    
}

/*! 监测网络 */
+ (void)AFNetworkStatus:(void (^)(AFNetworkReachabilityStatus status))block {
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      //未知
     AFNetworkReachabilityStatusNotReachable     = 0,       //无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       //蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       //WiFi
     };
     
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
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
        block(status);
    }] ;
    [manager startMonitoring];
}
- (void)cancelAllOperations {
    //取消所有的网络请求
    [self.httpJSONSessionManager.operationQueue cancelAllOperations];
}
@end
