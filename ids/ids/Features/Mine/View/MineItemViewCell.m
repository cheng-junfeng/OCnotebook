//
//  MineItemViewCell.m
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "MineItemViewCell.h"
#import "MineItemModel.h"

@interface MineItemViewCell ()
@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, strong) UILabel *alarmArea; //报警区域
@property (nonatomic, strong) UILabel *line; //线

@end

@implementation MineItemViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.alarmArea];
    [self.contentView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(20);
    }];
    [self.alarmArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark -  懒加载
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBCOLOR(243, 243, 243);
    }
    return _line;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentLeft font:KFont(16) textColor:[UIColor blackColor] text:@""];
    }
    return _titleLabel;
}
- (UILabel *)alarmArea {
    if (!_alarmArea) {
        _alarmArea = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentLeft font:KFont(14) textColor:[UIColor grayColor] text:@""];
    }
    return _alarmArea;
}

- (void)configCellWithModel:(MineItemModel *)model {
    self.titleLabel.text = model.title;
    self.alarmArea.text = model.content;
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
