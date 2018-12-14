//
//  RootNavigationController.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/14.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavigationController : UINavigationController

//旋转方向 默认竖屏
@property (nonatomic , assign) UIInterfaceOrientation interfaceOrientation;
@property (nonatomic , assign) UIInterfaceOrientationMask interfaceOrientationMask;

@end
