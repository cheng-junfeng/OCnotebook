//
//  HistoryItemCell.h
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseTableViewCell.h"
@class HistoryRealmModel;
@interface HistoryItemCell : BaseTableViewCell
- (void)configCellWithModel:(HistoryRealmModel *)model;
@end
