//
//  HomeItemViewCell.m
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "HomeItemViewCell.h"

@interface HomeItemViewCell ()

@property (nonatomic, strong) UILabel *titleName; //"东门监控海康威视高清摄像头",

@end

@implementation HomeItemViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self.contentView addSubview:self.titleName];
    
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
}
#pragma mark - 懒加载
- (UILabel *)titleName {
    if (!_titleName) {
        _titleName = [[UILabel alloc] init];
        _titleName.userInteractionEnabled = YES;
        _titleName.textAlignment = NSTextAlignmentCenter;
        _titleName.font  = KFont(18);
        _titleName.textColor = RGBCOLOR(100, 100, 100);

        
        _titleName.frame=CGRectMake(10, 7.5,screenWidth()/2, 100);
        _titleName.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _titleName.layer.cornerRadius = 5;
    }
    return _titleName;
}

- (void)configCellWithModel:(NSString *)title {
    self.titleName.text = title;
}
@end
