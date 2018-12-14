//
//  SPDatePickerView.m
//  ZEBBaseProject
//
//  Created by  on 2018/11/30.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "SPDatePickerView.h"

@interface SPDatePickerView()<CAAnimationDelegate>

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic) NSInteger *index;
@end

@implementation SPDatePickerView

- (instancetype)initWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate index:(NSInteger*) inde cancleBlock:(void(^)())cancleBlock doneBlock:(void(^)(NSInteger *index, NSDate *date))doneBlock{
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.index = inde;
    if (self) {
        [self addSubViewsWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate minimumDate:minimumDate maximumDate:maximumDate cancleBlock:^{
            cancleBlock();
        } doneBlock:^(NSInteger *index, NSDate *date) {
            doneBlock(index, date);
        }];
    }
    return self;
}

- (void)addSubViewsWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate cancleBlock:(void(^)())cancleBlock doneBlock:(void(^)(NSInteger *index, NSDate *date))doneBlock{
    self.cancleBlock = [cancleBlock copy];
    self.doneBlock = [doneBlock copy];
    
    //    self.backgroundColor = mRGBAColor(0, 0, 0, 0.3);
    self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    
    _backView = [[UIView alloc]init];
    [self addSubview:_backView];
    _backView.backgroundColor = [UIColor whiteColor];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@250);
    }];
    
    
    UIView *toolBarview = [[UIView alloc]init];
    toolBarview.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:toolBarview];
    [toolBarview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_backView);
        make.height.equalTo(@50);
    }];
    
    //取消和确认按钮
    UIButton *cancleButton = [[UIButton alloc]init];
    cancleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toolBarview addSubview:cancleButton];
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(toolBarview);
        make.width.equalTo(@(kScreenWidth/4));
    }];
    [cancleButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *doneButton = [[UIButton alloc]init];
    doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    doneButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [doneButton setTitleColor:RGBCOLOR(20, 124, 228) forState:UIControlStateNormal];
    [toolBarview addSubview:doneButton];
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(toolBarview);
        make.width.equalTo(@(kScreenWidth/4));
    }];
    [doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // line view
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, toolBarview.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
    lineView.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    [toolBarview addSubview:lineView];
    
    if (title) {
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [toolBarview addSubview:titleLable];
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.textColor = [UIColor blackColor];
        titleLable.text = title;
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(toolBarview);
            make.left.equalTo(cancleButton.mas_right);
            make.right.equalTo(doneButton.mas_left);
        }];
    }
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kScreenHeight-260, kScreenWidth, 260)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    
    // 设置时区
    [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 设置UIDatePicker的显示模式
    [_datePicker setDatePickerMode:datePickerMode];
    // 设置显示最大,最小时间
    if (minimumDate) {
        [_datePicker setMinimumDate:minimumDate];
    }
    if (maximumDate) {
        [_datePicker setMaximumDate:maximumDate];
    }
    // 设置当前显示时间
    if (selectedDate) {
        [_datePicker setDate:selectedDate];
    }
    [_backView addSubview:_datePicker];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(toolBarview.mas_bottom);
    }];
    
    [self animationWithView:_backView duration:0.2];
}

- (void)cancleButtonClick:(UIButton *)sender{
    
    [self animationWithViewDisappear];
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}

- (void)doneButtonClick:(UIButton *)sender{
    [self animationWithViewDisappear];
    if (self.doneBlock) {
        self.doneBlock(self.index, self.datePicker.date);
    }
}

#pragma mark -----CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeFromSuperview];
}

//从上往下移动
- (void)animationWithViewDisappear{
    [_backView.superview layoutIfNeeded];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom).offset(10);
        make.height.equalTo(@250);
    }];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.2f;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionReveal;
    //    animation.removedOnCompletion = NO;
    animation.subtype = kCATransitionFromBottom;
    [_backView.layer addAnimation:animation forKey:@"animation"];
}

//从下往上移动
- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow  addSubview:self];
}

@end
