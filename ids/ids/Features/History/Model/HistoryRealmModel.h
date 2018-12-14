//
//  HistoryRealmModel.h
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "RLMObject.h"

@interface HistoryRealmModel : RLMObject

@property NSString *id;      //from:
@property NSString *createTime;      //from:
@property NSString *content;      //from:
@property NSString *remark;      //from:
@property NSData *imageData;
@end
