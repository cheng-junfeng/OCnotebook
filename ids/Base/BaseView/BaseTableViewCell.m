//
//  BaseTableViewCell.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/9.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (NSString *)identifier {
    return NSStringFromClass(self.class);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
