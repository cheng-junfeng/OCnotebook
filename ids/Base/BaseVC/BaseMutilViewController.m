//
//  BaseMutilViewController.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/7.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "BaseMutilViewController.h"
#import "BaseViewController.h"

@interface BaseMutilViewController ()

@end

@implementation BaseMutilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    
    [self.magicController.magicView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.frame = self.view.bounds;
        _magicController.magicView.mj_y += getRectNavAndStatusHight;
        _magicController.magicView.mj_h -= getRectNavAndStatusHight;
        //_magicController.magicView.navigationHeight = 50.f;
        _magicController.magicView.layoutStyle = VTLayoutStyleCenter;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.separatorHidden = NO;
        _magicController.magicView.sliderHidden = NO;
        _magicController.magicView.sliderColor = RGBCOLOR(124, 207, 246);
        _magicController.magicView.itemSpacing = 80;
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(10, 0, 10, 0);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    if (self.menuList.count == 2) {
        magicView.layoutStyle = VTLayoutStyleDivide;
    } else {
        magicView.layoutStyle = VTLayoutStyleDefault;
    }
    return self.menuList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    MutilItem *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [MutilItem buttonWithType:UIButtonTypeCustom];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *identifier = @"pageVC";
    BaseViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
    if (!vc) {
        vc = [[BaseViewController alloc] init];
    }
    return vc;
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
