//
//  MineItemModel.m
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "MineItemModel.h"

@implementation MineItemModel
-(MineItemModel *)configModel:(BOOL) jump title:(NSString *)titl content:(NSString *)conten{
    self.canJump = jump;
    self.title = titl;
    self.content = conten;
    return self;
}
@end
