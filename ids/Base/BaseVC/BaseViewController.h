//
//  BaseViewController.h
//  ZEBBaseProject
//
//  Created by zm4 on 2018/7/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic) BOOL canTopRefresh;
@property(nonatomic) BOOL canBottomRefresh;
@property (nonatomic, strong) UITableView *tableView;

+ (NSString *)identifier;

- (void)registerClass;
- (void)initNotification;

- (void)loadData;
- (void)loadMore;

- (void)endRefresh;
- (void)beginRefresh;

@end
