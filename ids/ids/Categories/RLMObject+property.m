//
//  RLMObject+property.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/24.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "RLMObject+property.h"

@implementation RLMObject (property)


/*! 对象转字典 */
- (NSDictionary *)objectToDictionaryForSavePointItem { //保存巡检点
    return [self getObjectData:self removeObjs:@[@"realmItems",@"itemsIsNormal",@"selectItemsJson",@"isCache",@"fileItemsJson"]];
}
- (NSDictionary *)objectToDictionaryWithRemoveObjs:(NSArray *)objs {
    return [self getObjectData:self removeObjs:objs];
}
- (NSDictionary *)objectToDictionary {
    
    return  [self getObjectData:self removeObjs:@[]];
}
/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
- (NSDictionary*)getObjectData:(id)obj removeObjs:(NSArray *)objs {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList(NSClassFromString([[obj class] className]), &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        
        if (![objs containsObject:propName]) {
            id value = [obj valueForKey:propName];
            if(value == nil) {
                
                value = [NSNull null];
            } else {
                value = [self getObjectInternal:value removeObjs:objs];
            }
            [dic setObject:value forKey:propName];
        }
        
    }
    
    return dic;
}
- (id)getObjectInternal:(id)obj removeObjs:(NSArray *)objs {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i] removeObjs:objs] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[RLMArray class]]) {
        
        RLMArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i] removeObjs:objs] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key] removeObjs:objs] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj removeObjs:objs];
    
}

@end
