//
//  WSImageView.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/27.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "WSImageView.h"

@interface WSImageView ()

@property (nonatomic, strong) UILabel *redLabel;

@end

@implementation WSImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    NSInteger radius = 3;
    
    self.redLabel = [[UILabel alloc] init];
    self.redLabel.layer.backgroundColor = [UIColor redColor].CGColor;
    self.redLabel.layer.cornerRadius = radius;
    self.redLabel.hidden = YES;
    [self addSubview:self.redLabel];
    
    [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake(radius*2, radius*2));
    }];
}
- (void)alertShow:(BOOL)show {
    self.redLabel.hidden = !show;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
