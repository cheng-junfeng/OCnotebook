//
//  HistoryViewController.m
//  ids
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 . All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryItemCell.h"
#import "HistoryRealmModel.h"

@interface HistoryViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self registerClass];
    [self initUI];
    [self initNotification];
}

- (void)initData {
    RLMRealm *realm = [WSRealmHelper sharedInstance].realm;
    RLMResults *assetsItemsResults = [HistoryRealmModel allObjectsInRealm:realm];
    
    _list = [[NSMutableArray alloc] init];
    [_list removeAllObjects];
    if(assetsItemsResults.count > 0){
        for (HistoryRealmModel *itemRealm in assetsItemsResults) {
            [_list addObject:itemRealm];
        }
    }
    [self.tableView reloadData];
}

- (void)registerClass {
    [self.tableView registerClass:[HistoryItemCell class] forCellReuseIdentifier:[HistoryItemCell identifier]];
}

- (void)initUI {
    UIButton *rightBtn = [ZEBUI createButtonWithtarg:self sel:@selector(rightBtnClick) titColor:[UIColor whiteColor] font:KFont(15) image:nil backGroundImage:nil title:nil];
    [rightBtn setImage:[UIImage imageNamed:@"scan_action"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = [self.navigationItem rightItemsWithBarButtonItem:rightItem WithSpace:-5];
    
    self.tableView.separatorStyle = 0;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(getRectNavAndStatusHight);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:kHistoryControllerloadDataNotification object:nil];
}

-(void) rightBtnClick{
    [self showHint:@"scan"];
}
- (NSMutableArray *)list {
    if (!_list) {
        _list = [[NSMutableArray alloc] init];
    }
    return _list;
}
#pragma mark - tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[HistoryItemCell identifier]];
    HistoryRealmModel *model = self.list[indexPath.row];
    if (self.list.count > 0) {
        [cell configCellWithModel:model];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
    }else{
        if (self.list.count > 0) {
            HistoryRealmModel *model = self.list[indexPath.row];
            [self showHint:model.content];
        }
    }
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
