//
//  HttpsManager.h
//  ProjectTemplate
//
//  Created by -- on 16/7/17.
//  Copyright © 2016年 Jomper Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

/** 请求取消的Block */
typedef void (^cancelCompletedBlock)(BOOL results,NSString * urlString);

@interface HttpsManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *httpJSONSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *httpLoginSessionManager; //登录定制
/**
 * 创建一个HttpsManager单例对象
 */
+ (nonnull HttpsManager *)sharedManager;

/**
 * get请求
 */
- (void)get:(nonnull NSString *)urlString
 parameters:(nonnull NSDictionary *)param
   progress:(nonnull void(^)(NSProgress * _Nonnull progress)) progressBlock
    success:(nonnull void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable response))successBlock
    failure:(nonnull void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;
- (void)getJSON:(NSString *)urlString
     parameters:(NSDictionary *)param
       progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock
        success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable response))successBlock
        failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;
/**
 * post请求
 */
- (void)post:(nonnull NSString *)urlString
  parameters:(nonnull NSDictionary *)param
    progress:(nonnull void(^)(NSProgress * _Nonnull progress)) progressBlock
     success:(nonnull void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable reponse))successBlock
     failure:(nonnull void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;
- (void)loginPost:(NSString *)urlString
       parameters:(NSDictionary *)param
         progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock
          success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable reponse))successBlock
          failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;
- (NSURLSessionDataTask *)postJSON:(NSString *)urlString
      parameters:(NSDictionary *)param
        progress:(void(^)(NSProgress * _Nonnull progress)) progressBlock
         success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable reponse))successBlock
         failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;
/*! 监测网络 */
+ (void)AFNetworkStatus:(void (^)(AFNetworkReachabilityStatus status))block;
// 取消所有网络请求
- (void)cancelAllOperations;
@end
