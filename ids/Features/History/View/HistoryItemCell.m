//
//  AssetMainTableCell.m
//  ZEBBaseProject
//
//  Created by  on 2018/8/22.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "HistoryItemCell.h"
#import "HistoryRealmModel.h"

@interface HistoryItemCell ()

@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, strong) UILabel *alarmArea; //区域
@property (nonatomic, strong) UILabel *alarmTimeLabel; //时间
@property (nonatomic, strong) UILabel *stateLabel; //状态

@property (nonatomic, strong) UILabel *line; //线

@end

@implementation HistoryItemCell

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
    [self.contentView addSubview:self.alarmTimeLabel];
    [self.contentView addSubview:self.line];
    
    CGFloat topMargin = 20;
    CGFloat centerMargin = 10;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.top.equalTo(self.contentView.mas_top).offset(topMargin);
        make.height.mas_equalTo(20);
        make.width.mas_lessThanOrEqualTo(200);
    }];
    [self.alarmArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(centerMargin);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    [self.alarmTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.alarmArea.mas_bottom).offset(centerMargin);
        make.width.mas_lessThanOrEqualTo(250);
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
        _titleLabel = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentLeft font:KFont(14) textColor:[UIColor blackColor] text:@""];
    }
    return _titleLabel;
}
- (UILabel *)alarmArea {
    if (!_alarmArea) {
        _alarmArea = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentLeft font:KFont(14) textColor:[UIColor blackColor] text:@""];
    }
    return _alarmArea;
}

- (UILabel *)alarmTimeLabel {
    if (!_alarmTimeLabel) {
        _alarmTimeLabel = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentLeft font:KFont(14) textColor:[UIColor blackColor] text:@""];
    }
    return _alarmTimeLabel;
}

- (void)configCellWithModel:(HistoryRealmModel *)model {
    
    self.titleLabel.text = [NSString stringWithFormat:@"时间：%@",model.createTime];
    
    NSString *alarmAreaNameString = [NSString stringWithFormat:@"内容：%@",model.content];
    NSRange alarmAreaNameRang = [alarmAreaNameString rangeOfString:@"内容："];
    self.alarmArea.attributedText = [ZEBUtils updageBanlence:alarmAreaNameString color:RGBCOLOR(110, 110, 110) rang:alarmAreaNameRang];
    
    NSString *alarmTimeLabelString = [NSString stringWithFormat:@"描述：%@",model.remark];
    NSRange alarmTimeLabelRang = [alarmTimeLabelString rangeOfString:@"描述："];
    self.alarmTimeLabel.attributedText = [ZEBUtils updageBanlence:alarmTimeLabelString color:RGBCOLOR(110, 110, 110) rang:alarmTimeLabelRang];
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
