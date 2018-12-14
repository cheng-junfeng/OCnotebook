//
//  BaseMutilViewController.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/7.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VTMagic.h>
#import "MutilItem.h"

@interface BaseMutilViewController : UIViewController<VTMagicViewDataSource, VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) NSArray *menuList;

@end
