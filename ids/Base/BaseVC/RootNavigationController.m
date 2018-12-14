//
//  RootNavigationController.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/14.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
    self.interfaceOrientation = UIInterfaceOrientationPortrait;
}
/// 当前的导航控制器是否可以旋转
-(BOOL)shouldAutorotate{
    
    return YES;
}

//设置支持的屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return self.interfaceOrientationMask;
}

//设置presentation方式展示的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return self.interfaceOrientation;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
