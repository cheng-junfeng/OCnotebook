//
//  MineItemModel.h
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineItemModel : NSObject
@property (nonatomic) BOOL canJump;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
-(MineItemModel *)configModel:(BOOL) jump title:(NSString *)titl content:(NSString *)conten;
@end
