//
//  MutilItem.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/7.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "MutilItem.h"

@interface MutilItem ()

@property (nonatomic, strong) UILabel *dotLabel;

@end

@implementation MutilItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:RGBCOLOR(95, 204, 255) forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    self.dotLabel = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentLeft font:KFont(13) textColor:RGBCOLOR(93, 203, 212) text:@""];
    self.dotLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.dotLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect titleRect = self.titleLabel.frame;
    self.dotLabel.frame = CGRectMake(CGRectGetMaxX(titleRect), CGRectGetMinY(titleRect), self.width-CGRectGetMaxX(titleRect), self.titleLabel.height);
}
- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5.f;
    frame.size.width -= 10.f;
    [super setFrame:frame];
}
- (void)setOtherTitle:(NSString *)otherTitle {
    self.dotLabel.text = otherTitle;
}
#pragma mark - accessor methods


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
