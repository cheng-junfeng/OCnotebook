//
//  ZEBUI.h
//  ZEBBaseProject
//
//  Created by zm4 on 2018/7/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CanCelBlock)(UIAlertAction *action);
typedef void(^DefaultBlock)(UIAlertAction *action);
typedef void(^ZEBAlertCompletionBlock)(UIAlertController *alert);

@interface ZEBUI : NSObject

+ (UILabel*)createLabelWithbackGroundColor:(UIColor*)bgColor textAlignment:(NSInteger)alignment font:(UIFont *)font textColor:(UIColor*)textColor  text:(NSString*)text;
+ (UILabel *)createBlueLabel;
+ (UILabel *)createLine;
+ (UIImageView*)createImageWithbackGroundImageV:(NSString*)imageName;

+ (UIButton*)createButtonWithtarg:(id)targ sel:(SEL)sel titColor:(UIColor*)titleColor font:(UIFont*)font  image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title;

+(void)presentAlertStyleDefauleForTitle:(NSString *)title andMessage:(NSString *)message andCancel:(CanCelBlock)selectCancel andDefault:(DefaultBlock )selectDefault andCompletion:(ZEBAlertCompletionBlock)completion;

+(void)presentAlertStyleDefauleForTitle:(NSString *)title andMessage:(NSString *)message andCancel:(CanCelBlock)selectCancel andCompletion:(ZEBAlertCompletionBlock)completion;

+ (void)presentAlertToCancelWithMessage:(NSString *)message WithObject:(id)obj;


@end
