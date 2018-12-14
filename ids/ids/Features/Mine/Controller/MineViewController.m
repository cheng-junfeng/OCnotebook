//
//  MineViewController.m
//  ids
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 . All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderCell.h"
#import "MineItemViewCell.h"
#import "MineItemModel.h"

@interface MineViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(228, 228, 228);

    [self initData];
    [self registerClass];
    [self initUI];
}

- (void)initData {
    _list = [[NSMutableArray alloc] init];
    MineItemModel *temp1 = [[MineItemModel alloc] init];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [_list addObject:[temp1 configModel:NO title:@"版本" content:currentVersion]];
    MineItemModel *temp2 = [[MineItemModel alloc] init];
    [_list addObject:[temp2 configModel:YES title:@"关于" content:@"https://cheng_junfeng.github.io"]];
    [self.tableView reloadData];
}

- (void)registerClass {
    [self.tableView registerClass:[MineHeaderCell class] forCellReuseIdentifier:[MineHeaderCell identifier]];
    [self.tableView registerClass:[MineItemViewCell class] forCellReuseIdentifier:[MineItemViewCell identifier]];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineHeaderCell identifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    MineItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineItemViewCell identifier]];
    MineItemModel *model = self.list[indexPath.row];
    cell.selectionStyle = model.canJump ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone;
    if (self.list.count > 0) {
        [cell configCellWithModel:model];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 200;
    }else{
        return 60;
    }
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
            MineItemModel *model = self.list[indexPath.row];
            if(model.canJump){
                [self showHint:model.content];
            }
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
