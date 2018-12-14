/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import <objc/runtime.h>


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}
- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint Time:(NSTimeInterval) time {
    MBProgressHUD *HUD = [self HUD];
    if (HUD) {
        [HUD hideAnimated:NO];
    }
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.alpha = 1.0;
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
    [self setHUD:hud];
}

- (void)showHint:(NSString *)hint
{
   MBProgressHUD *HUD = [self HUD];
    if (HUD) {
        [HUD hideAnimated:NO];
    }
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.alpha = 1.0;
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, IS_IPHONE_5?200.f:150.f);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    [self setHUD:hud];
    
}
- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}


- (void)showLoginLoading:(NSString *)loadingName {
    UIView *view =[[ UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.minSize = CGSizeMake(210, 100);
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.text = loadingName;
    hud.margin = 14.f;
    hud.backgroundColor = [UIColor whiteColor];
    hud.alpha = 1.0;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:10];
    [hud removeFromSuperViewOnHide];
    [self setHUD:hud];
}

- (void)showloadingName:(NSString *)loadingName
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = YES;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = loadingName;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.margin = 12.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:10];
    
    
    [hud removeFromSuperViewOnHide];
    [self setHUD:hud];
}


- (void)showloadingError:(NSString *)errorInfo
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imageV setImage:[UIImage imageNamed:@"hud_error.png"]];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = imageV;
    hud.label.text = errorInfo;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.margin = 12.f;
    //hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    
    
    [hud removeFromSuperViewOnHide];
    [self setHUD:hud];

}


- (void)showloadingNameHor:(NSString *)loadingName
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = YES;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = loadingName;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.margin = 12.f;
    //hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    [self setHUD:hud];
}

@end
