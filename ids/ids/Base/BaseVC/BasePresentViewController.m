//
//  BasePresentViewController.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/9/6.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "BasePresentViewController.h"
#import "UIButton+EnlargeEdge.h"

@interface BasePresentViewController ()

@end

@implementation BasePresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationView];
    
}

- (void)initNavigationView {
    
    [self.view addSubview:self.navigationView];
    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(44+getStatusBarHight);
    }];
}
- (void)initTitleLabel {
    
    [self.navigationView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
        make.height.mas_equalTo(25);
        make.centerX.equalTo(self.navigationView.mas_centerX);
        make.width.mas_equalTo(150);
    }];
}
- (void)initLeftBtn {
    
    [self.navigationView addSubview:self.leftBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationView.mas_left).offset(5);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
}
- (void)initRightBtn {
    
    [self.navigationView addSubview:self.rightBtn];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView.mas_right).offset(-20);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_lessThanOrEqualTo(80);
    }];
}
- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = RGBCOLOR(20, 124, 228);
    }
    return _navigationView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [ZEBUI createLabelWithbackGroundColor:nil textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:18] textColor:[UIColor whiteColor] text:@""];
    }
    return _titleLabel;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [ZEBUI createButtonWithtarg:self sel:@selector(leftBtnAction:) titColor:[UIColor whiteColor] font:KFont(15) image:@"white_back" backGroundImage:nil title:nil];
        [_leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [ZEBUI createButtonWithtarg:self sel:@selector(rightBtnAction:) titColor:[UIColor whiteColor] font:KFont(15) image:nil backGroundImage:nil title:nil];
        [_rightBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    }
    return _rightBtn;
}

- (void)leftBtnAction:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBtnAction:(UIButton *)btn {
    
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
