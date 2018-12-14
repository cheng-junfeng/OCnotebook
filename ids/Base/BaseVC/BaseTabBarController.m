//
//  BaseTabBarController.m
//  ZEBBaseProject
//
//  Created by zm4 on 2018/7/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController () {
    UIImageView *_splshImageView;
}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)crateLanchAnimation {
    _splshImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    // 取启动动画图片的路径
    NSString *splshImagePath = [[NSBundle mainBundle] pathForResource:@"start" ofType:@"png"];
    _splshImageView.image = [[UIImage alloc] initWithContentsOfFile:splshImagePath];
    [self.view addSubview:_splshImageView];
    [UIView animateWithDuration:3.0 animations:^{
        _splshImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_splshImageView removeFromSuperview];
    }];
}
/// 选择的当前控制器是否可以旋转
-(BOOL)shouldAutorotate{
    
    return [self.selectedViewController shouldAutorotate];
}

/// 选择的当前控制器是支持的旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return  [self.selectedViewController supportedInterfaceOrientations];
}

///
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return  [self.selectedViewController preferredInterfaceOrientationForPresentation];
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
