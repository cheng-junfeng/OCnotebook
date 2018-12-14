//
//  LoopProgressView.h
//  头像蒙板
//
//  Created by CUG on 16/1/29.
//  Copyright © 2016年 CUG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopProgressView : UIView
-(void)addProgress:(CGFloat) progress;
- (void)show;
- (void)dismiss;
@end

