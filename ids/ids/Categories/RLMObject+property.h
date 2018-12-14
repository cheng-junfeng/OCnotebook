//
//  RLMObject+property.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/24.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "RLMObject.h"

@interface RLMObject (property)

/*! 对象转字典 */
- (NSDictionary *)objectToDictionary;
- (NSDictionary *)objectToDictionaryForSavePointItem;
- (NSDictionary *)objectToDictionaryForSaveTourPointItem;
- (NSDictionary *)objectToDictionaryWithRemoveObjs:(NSArray *)objs;

@end
