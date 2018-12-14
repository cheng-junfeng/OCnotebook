//
//  PublicDefine.h
//  UserClient
//
//  Created by zm4 on 2017/7/7.
//  Copyright © 2017年 StenpZ. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

//// 全局性的头文件
//#ifdef __OBJC__
//#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
//#endif

// Debug下打印，Release下不打印
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#endif /* PublicDefine_h */
