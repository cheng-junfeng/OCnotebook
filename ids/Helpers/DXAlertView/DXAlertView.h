//
//  DXAlertView.h
//  Elephant
//
//  Created by dyy on 2018/1/19.
//  Copyright © 2018年 dyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXAlertView;

typedef enum : NSUInteger {
    OfflineEnetrAlert
} HINTSTYPE;

@protocol DXAlertViewDelegate <NSObject>
@optional
- (void)dxAlertView:(DXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end;

@interface DXAlertView : UIView

@property (nonatomic,strong)UILabel *messageLab;
@property (nonatomic,weak)id<DXAlertViewDelegate>delegate;

/**
 初始化Alertview

 @param title 标题
 @param message 内容
 @param cancelTitle 取消按钮
 @param otherBtnTitle 确定按钮
 @return self
 */
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle;
/**
 初始化Alertview
 
 @param title 标题
 @param message 内容
 @param cancelTitle 取消按钮
 @param otherBtnTitle 确定按钮
 @param hintsTitle 不在提示按钮
 @param hintsType hintstype类型
 @return self
 */
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle hintsTitle:(NSString *)hintsTitle hintsType:(HINTSTYPE)hintsType;
-(void)show;
- (void)showHints;

@end
