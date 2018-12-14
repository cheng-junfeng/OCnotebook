//
//  ScanViewController.h
//  ids
//
//  Created by  on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "LBXScanViewController.h"

#import <UIKit/UIKit.h>
#import <LBXScanViewController.h>
typedef void(^QrcodeScan)(NSString *qrcode);
@interface ScanViewController : LBXScanViewController

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;

- (void)scanResult:(NSString*)strResult;
- (void)configCellWithTitle:(BOOL) need onSelect:(QrcodeScan) select;

@property (nonatomic, copy) NSString *ASId;

@end

