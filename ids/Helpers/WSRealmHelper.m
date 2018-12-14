//
//  WSUpdateRealm.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/28.
//  Copyright © 2018年 zm4. All rights reserved.
//  数据库管理类

#import "WSRealmHelper.h"

@implementation WSRealmHelper

+ (WSRealmHelper *)sharedInstance
{
    __strong static id _sharedObject = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (_sharedObject == nil) {
            _sharedObject = [[self alloc] init];
        }
    }
    return _sharedObject;
}
/*! 配置数据库 */
- (instancetype)init {
    self = [super init];
    if (self) {
        [self doRefresh];
    }
    return self;
}
/*! 切换数据库 */
+ (void)refreshRealm {
    WSRealmHelper *instance = [self sharedInstance];
    [instance doRefresh];
}
/*! 切换数据库目录 重新配置数据库路径 */
- (void)doRefresh {
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"ids.realm"];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {
        // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
}
/*! 返回当前数据库对象 */
- (RLMRealm *)realm {
    return [RLMRealm defaultRealm];
}
@end
