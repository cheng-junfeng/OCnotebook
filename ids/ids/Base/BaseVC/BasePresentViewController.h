//
//  BasePresentViewController.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/9/6.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "BaseViewController.h"

@interface BasePresentViewController : BaseViewController

/*! 顶部view */
@property (nonatomic, strong) UIView *navigationView;
/*! 左边按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/*! title */
@property (nonatomic, strong) UILabel *titleLabel;
/*! 右边按钮 */
@property (nonatomic, strong) UIButton *rightBtn;

/*! 添加顶部view */
- (void)initNavigationView;
/*! 添加title */
- (void)initTitleLabel;
/*! 添加左按钮 */
- (void)initLeftBtn;
/*! 添加右按钮 */
- (void)initRightBtn;
/*! leftButton action */
- (void)leftBtnAction:(UIButton *)btn;
/*! rightButton action */
- (void)rightBtnAction:(UIButton *)btn;

@end
