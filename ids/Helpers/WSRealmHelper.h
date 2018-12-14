//
//  WSUpdateRealm.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/28.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRealmHelper : NSObject

@property (nonatomic, strong) RLMRealm *realm;

+ (WSRealmHelper*)sharedInstance;
/*! 切换数据库 */
+ (void)refreshRealm;
@end
