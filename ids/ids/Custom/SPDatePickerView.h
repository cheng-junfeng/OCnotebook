//
//  SPDatePickerView.h
//  ZEBBaseProject
//
//  Created by  on 2018/11/30.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancleBlock)();
typedef void (^DoneBlocks)(NSInteger *index, NSDate *date);

@interface SPDatePickerView : UIView

@property (nonatomic, copy) CancleBlock cancleBlock;
@property (nonatomic, copy) DoneBlocks doneBlock;

/**
 SPDatePickerView
 
 @param title 中间的标题
 @param datePickerMode 选择时间的类型
 @param selectedDate 默认显示的时间点
 @param minimumDate 最小时间点
 @param maximumDate 最大时间点
 @param cancleBlock 取消按钮的回调
 @param doneBlock 确定按钮的回调
 @return self
 */
- (instancetype)initWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate index:(NSInteger*) index cancleBlock:(void(^)())cancleBlock doneBlock:(void(^)(NSInteger *index, NSDate *date))doneBlock;
/**
 显示SPDatePickerView展示
 */
- (void)show;

@end
