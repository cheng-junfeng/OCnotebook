//
//  HomeViewController.m
//  ids
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 . All rights reserved.
//

#import "HomeViewController.h"
#import "HomeItemViewCell.h"
#import "ScanViewController.h"
#import "HistoryRealmModel.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    CGFloat _item_W;
    CGFloat _item_H;
    CGFloat _centerMargin;
    CGFloat _leftMargin;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *allSource;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(228, 228, 228);
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    _leftMargin = 10;
    _centerMargin = 5;
    _item_W = (kScreenWidth - _leftMargin*2 - _centerMargin*2)/2;
    _item_H = 100;
    
    [self initData];
    [self initUI];
}

- (void)initData {
    _allSource = [[NSMutableArray alloc] init];
    [_allSource addObject:@"扫码"];
    [_allSource addObject:@"导出"];
    [self.collectionView reloadData];
}

- (void)initUI {
    UIButton *rightBtn = [ZEBUI createButtonWithtarg:self sel:@selector(rightBtnClick) titColor:[UIColor whiteColor] font:KFont(15) image:nil backGroundImage:nil title:nil];
    [rightBtn setImage:[UIImage imageNamed:@"scan_action"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = [self.navigationItem rightItemsWithBarButtonItem:rightItem WithSpace:-5];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(getRectNavAndStatusHight);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void) rightBtnClick{
    [self showHint:@"scan"];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake(_item_W, _item_H);
        
        CGFloat bottomMargin = 0;
        if (isIPhoneXSeries()) {
            bottomMargin = 0;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = RGBCOLOR(238, 238, 238);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HomeItemViewCell class] forCellWithReuseIdentifier:[HomeItemViewCell identifier]];
    }
    return _collectionView;
}
- (NSMutableArray *)allSource {
    if (!_allSource) {
        _allSource = [[NSMutableArray alloc] init];
    }
    return _allSource;
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeItemViewCell *cell = (HomeItemViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[HomeItemViewCell identifier] forIndexPath:indexPath];
    NSString *model =self.allSource[indexPath.item];
    [cell configCellWithModel:model];
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_item_W, _item_H);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, _leftMargin, 0, _leftMargin);
}
//
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return _centerMargin;
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _leftMargin;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.item == 0){
//        ScanViewController *scan = [[ScanViewController alloc] init];
//        scan.hidesBottomBarWhenPushed = YES;
//        scan.libraryType = SLT_ZXing;
//        scan.scanCodeType =  SCT_QRCode;
//        scan.isVideoZoom = YES;
//        [self.navigationController pushViewController:scan animated:YES];
        RLMRealm *realm = [WSRealmHelper sharedInstance].realm;
        
        HistoryRealmModel *item = [[HistoryRealmModel alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *datenow = [NSDate date];
        item.createTime = [formatter stringFromDate:datenow];
        item.content = @"www.baidu.com";
        item.remark = @"nothing";
        
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:item];
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:kHistoryControllerloadDataNotification object:nil];
    }else{
        NSString *model =self.allSource[indexPath.item];
        [self showHint:model];
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
