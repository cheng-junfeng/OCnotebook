//
//  NSObject+property.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/2.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (property)

//获取对象的所有属性
- (NSArray *)getAllProperties;
/*! 对象转字典 */
- (NSDictionary *)objectToDictionary;
- (NSDictionary *)objectToDictionaryForSaveTourPointItem;
@end
