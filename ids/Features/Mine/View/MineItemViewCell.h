//
//  MineItemViewCell.h
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseTableViewCell.h"
@class MineItemModel;
@interface MineItemViewCell : BaseTableViewCell
- (void)configCellWithModel:(MineItemModel *)model;
@end
