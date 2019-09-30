//
//  SVCMovieDetailViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCMovieDetailViewController.h"
#import "SVCMoviePlayerModel.h"
#import "SVCRechargeVC.h"
#import "SVCMovieDetailCell.h"
#import "SVCMoviePlayerViewController.h"

@interface SVCMovieDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray *dataList; /**<<#属性#> */
@property(nonatomic, copy) NSString *categoryID; /**<<#属性#> */
@property(nonatomic, copy) NSString *page; /**<<#属性#> */
@property(nonatomic, copy) NSString *pageNum; /**<<#属性#> */

@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation SVCMovieDetailViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

//支持旋转
- (BOOL)shouldAutorotate{
    return YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataList;
}

- (instancetype)initWithCategoryID:(NSString *)ID{
    if (self = [super init]) {
        _categoryID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = @"1";
    self.pageNum = @"15";
    
    // kindView
    CGRect kindRect = CGRectMake(0, 0, SCR_WIDTH, SCREEN_HEIGHT - Nav_HEIGHT - Tabbar_HEIGHT);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(JXHeight(10), JXWidth(5), 0, JXWidth(5));
    layout.minimumInteritemSpacing = 0 ;
    layout.minimumLineSpacing = 0 ;
    self.collectionView = [[UICollectionView alloc] initWithFrame:kindRect collectionViewLayout:layout];
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - Nav_HEIGHT - Tabbar_HEIGHT);
//    self.collectionView.backgroundColor = SVCMarginColorf5;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SVCMovieDetailCell" bundle:nil] forCellWithReuseIdentifier:@"SVCMovieDetailCell"];
    [self.view addSubview:self.collectionView];
    
    [self getNovelWithID:_categoryID page:self.page];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer.hidden = YES;
    WS(weakSelf)
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.collectionView.mj_header beginRefreshing];
        [weakSelf getNovelWithID:weakSelf.categoryID page:@"1"];
    }];
}

- (void)getNovelWithID:(NSString *)ID page:(NSString *)page{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:ID forSafeKey:@"cate_id"];
    [params setSafeObject:page forSafeKey:@"page"];
    [params setSafeObject:self.pageNum forSafeKey:@"limit"];
    [SVCCommunityApi getMoviewListWithParams:params BlockSuccess:^(NSInteger code, NSString *msg, NSArray *json) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        if (code == 0) {
            if (page.integerValue == 1) {
                [self.dataList removeAllObjects];
            }
            
            self.page = [NSString stringWithFormat:@"%ld",self.page.integerValue + 1];
            NSArray *tmpList = [SVCMoviePlayerModel mj_objectArrayWithKeyValuesArray:json];
            [self.dataList addObjectsFromArray:tmpList];
            if (tmpList.count < self.pageNum.integerValue) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                self.collectionView.mj_footer.hidden = YES;
            }else{
                self.collectionView.mj_footer.hidden = NO;
            }
            [self.collectionView reloadData];
        }
    } andfail:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil || token.length == 0) {
        SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
        SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    if (self.isSelectedCell == NO) {
        self.isSelectedCell = YES;
        
        [SVCCommunityApi checkVIPWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                SVCMoviePlayerModel *model = self.dataList[indexPath.item];
                SVCMoviePlayerViewController *vc = [[SVCMoviePlayerViewController alloc] initWithMovieURL:model.pingtai];
                vc.title = model.title;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (code == -1){
                // 不是vip 进入充值界面
                [self gotochargeVC:msg];
            }else if(code == -997){
                SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
                SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
            }
        } andfail:^(NSError *error) {
            self.isSelectedCell = NO;
        }];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SVCMovieDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCMovieDetailCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SVCMovieDetailCell" owner:nil options:nil].lastObject;
    }
    [cell setUpMovieModel:self.dataList[indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JXWidth(179), JXHeight(175));
}

- (void)loadMore{
    [self getNovelWithID:_categoryID page:self.page];
}


- (void)gotochargeVC:(NSString *)msg
{
    WS(weakSelf);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* shareAction = [UIAlertAction actionWithTitle:@"分享赚时间" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * action) {
        SVCinvateFriendsViewController *chargeVC = [[SVCinvateFriendsViewController alloc] init];
        [weakSelf.navigationController pushViewController:chargeVC animated:YES];
    }];
    
    UIAlertAction* okeyAction = [UIAlertAction actionWithTitle:@"充值续费" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * action) {
        SVCRechargeVC *chargeVC = [[SVCRechargeVC alloc] init];
        [weakSelf.navigationController pushViewController:chargeVC animated:YES];
    }];
    [alert addAction:okeyAction];
    [alert addAction:shareAction];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
