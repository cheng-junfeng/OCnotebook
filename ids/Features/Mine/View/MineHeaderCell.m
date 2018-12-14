//
//  MineHeaderCell.m
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "MineHeaderCell.h"

@interface MineHeaderCell ()

@property (nonatomic, strong) UIImageView *codeImage;

@end

@implementation MineHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    self.contentView.backgroundColor = RGBCOLOR(52, 141, 229);
    int butt_width = (kScreenWidth)/3;
    [self.contentView addSubview:self.codeImage];
    
    [self.codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(butt_width);
        make.width.mas_equalTo(butt_width);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)codeImage {
    
    if (!_codeImage) {
        _codeImage = [[UIImageView alloc] init];
        [_codeImage setImage:[UIImage imageNamed:@"mine_qrcode"]];
        _codeImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _codeImage;
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
