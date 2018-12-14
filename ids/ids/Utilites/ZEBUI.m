//
//  ZEBUI.m
//  ZEBBaseProject
//
//  Created by zm4 on 2018/7/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "ZEBUI.h"

@implementation ZEBUI

+ (UILabel*)createLabelWithbackGroundColor:(UIColor*)bgColor textAlignment:(NSInteger)alignment font:(UIFont *)font textColor:(UIColor*)textColor  text:(NSString*)text{
    UILabel * label = [[UILabel   alloc]init];
    if (bgColor) {
        label.backgroundColor  = bgColor;
    }
    label.userInteractionEnabled = YES;
    label.textAlignment = alignment;
    label.font  = font;
    label.textColor = textColor;
    label.text  =  text;
    
    return label;
}
+ (UILabel *)createBlueLabel {
    UILabel *blueLabel = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] textColor:nil text:nil];
    blueLabel.layer.cornerRadius = 2;
    blueLabel.layer.backgroundColor = RGBCOLOR(49, 162, 248).CGColor;
    return blueLabel;
}
+ (UILabel *)createLine {
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBCOLOR(243, 243, 243);
    return line;
}
+ (UIImageView*)createImageWithbackGroundImageV:(NSString*)imageName{
    UIImageView * imageV = [[UIImageView alloc]init];
    imageV.userInteractionEnabled = YES;
    if (imageName) {
       imageV.image = [UIImage imageNamed:imageName];
    }
    return imageV;
}

+ (UIButton*)createButtonWithtarg:(id)targ sel:(SEL)sel titColor:(UIColor*)titleColor font:(UIFont*)font  image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}

+(void)presentAlertStyleDefauleForTitle:(NSString *)title andMessage:(NSString *)message andCancel:(CanCelBlock)selectCancel andDefault:(DefaultBlock )selectDefault andCompletion:(ZEBAlertCompletionBlock)completion
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
        selectCancel(action);
        //            NSLog(@"返回");
    }];
    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        selectDefault(action);
        //            NSLog(@"确认");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    
    completion(alert);
}

+(void)presentAlertStyleDefauleForTitle:(NSString *)title andMessage:(NSString *)message andCancel:(CanCelBlock)selectCancel andCompletion:(ZEBAlertCompletionBlock)completion
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
        selectCancel(action);
        //            NSLog(@"返回");
    }];
    
    [alert addAction:action1];
    
    completion(alert);
}

+ (void)presentAlertToCancelWithMessage:(NSString *)message WithObject:(id)obj {
    [self presentAlertStyleDefauleForTitle:@"温馨提示" andMessage:message andCancel:^(UIAlertAction *action) {
        
    } andCompletion:^(UIAlertController *alert) {
        [obj presentViewController:alert animated:YES completion:nil];
    }];
}

@end
