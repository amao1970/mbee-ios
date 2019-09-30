//
//  VDKindVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDKindVC.h"

// view
#import "JXMovieOfStyleBigCell.h"
#import "VDKindHeadView.h"

// model
#import "SVCHomePageModel.h"

// vc
#import "SVCVideoDetailViewController.h"

@interface VDKindVC ()<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<SVCHomePageModel*>* dataList;
@property (nonatomic, strong) VDKindHeadView *headView;
@property (nonatomic, strong) NSMutableArray* categoryList;
@property (nonatomic, strong) NSMutableArray* tagsList;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */
@property(nonatomic, copy) NSString *page; /**<<#属性#> */
@property(nonatomic, copy) NSString *pageNum; /**<<#属性#> */

@end

@implementation VDKindVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = @"1";
    self.pageNum = @"15";
    
    self.dataList = [NSMutableArray array];
    [self setUpCollectionView];
    [self getNetData];
    [self getVideoDateWithPage:self.page];
}

-(void)getNetData{
    [JXAFNetWorking method:@"/mobile/index/searchcate" parameters:nil finished:^(JXRequestModel *obj) {
        self.categoryList = [obj getResultDictionary][@"category"];
        self.tagsList = [obj getResultDictionary][@"tags"];
        __block NSMutableArray *categoryAry = [NSMutableArray array];
        __block NSMutableArray *tagsAry = [NSMutableArray array];
        [self.categoryList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [categoryAry addObject:obj[@"title"]];
        }];
        [self.tagsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tagsAry addObject:obj[@"name"]];
        }];
        self.headView.sortString = self.sort;
        self.headView.kindString = self.cate;
        self.headView.tagString = self.tag;
        self.headView.tagList = tagsAry;
        self.headView.kindList = categoryAry;
        self.headView.sortList = @[@"最新上传",@"热门点击",@"精彩推荐"].mutableCopy;
        [self.collectionView.mj_header endRefreshing];
    } failed:^(JXRequestModel *obj) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)getVideoDateWithPage:(NSString *)page{
    [WsHUD showHUDWithLabel:@"正在获取..." modal:NO timeoutDuration:40.0];
    NSDictionary *dic = @{@"title":self.titleStr ? self.titleStr : @"",
                          @"tag":self.tag ? self.tag : @"",
                          @"cate":self.cateID ? self.cateID : @"",
                          @"sortby":self.sort ? self.sort : @"",
                          @"page":page,
                          @"limit":self.pageNum
                          };
    [JXAFNetWorking method:@"/mobile/index/search" parameters:dic finished:^(JXRequestModel *obj) {
        if (page.integerValue == 1) {
            [self.dataList removeAllObjects];
            
        }
        self.page = [NSString stringWithFormat:@"%ld",self.page.integerValue + 1];
        NSMutableArray<SVCHomePageModel*> *tmpAry = [SVCHomePageModel mj_objectArrayWithKeyValuesArray:[obj getResultDictionary][@"lists"]];
        [self.dataList addObjectsFromArray:tmpAry];
        if (tmpAry.count < self.pageNum.integerValue) {
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//            self.collectionView.mj_footer.hidden = YES;
        }else{
            [self.collectionView.mj_footer endRefreshing];
//            self.collectionView.mj_footer.hidden = NO;
        }
        [self.collectionView reloadData];
        [WsHUD hideHUD];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        [self.collectionView.mj_footer endRefreshing];
//        self.collectionView.mj_footer.hidden = NO;
    }];
}

- (void)loadMore{
    [self getVideoDateWithPage:self.page];
}

-(void)setUpCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0 ;
    layout.minimumLineSpacing = 0 ;
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT -Nav_HEIGHT);
    if (self.navigationController.viewControllers.count <= 1) {
        rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT -Nav_HEIGHT- Tabbar_HEIGHT);
    }
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXMovieOfStyleBigCell" bundle:nil] forCellWithReuseIdentifier:@"JXMovieOfStyleBigCell"];
    MJWeakSelf
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.collectionView.mj_footer resetNoMoreData];
        [weakSelf getNetData];
        [weakSelf getVideoDateWithPage:@"1"];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    if (!self.hiddenHeadView) {
        //
        CGRect advScrollViewrect = CGRectMake(0, 0, SCR_WIDTH, JXHeight(130));
        self.headView = [[VDKindHeadView alloc] init];
        self.headView.frame= advScrollViewrect;
        SVCWeakSelf;
        self.headView.sortblock = ^(NSInteger tag) {
            [weakSelf.collectionView.mj_footer resetNoMoreData];
            weakSelf.collectionView.mj_footer.hidden = NO;
            weakSelf.sort = weakSelf.headView.sortList[tag];
            [weakSelf getVideoDateWithPage:@"1"];
        };
        self.headView.kindblock = ^(NSInteger tag) {
            [weakSelf.collectionView.mj_footer resetNoMoreData];
            weakSelf.collectionView.mj_footer.hidden = NO;
            NSDictionary *dic = weakSelf.categoryList[tag];
            weakSelf.cateID = dic[@"id"];
            [weakSelf getVideoDateWithPage:@"1"];
        };
        self.headView.tagsblock = ^(NSInteger tag) {
            [weakSelf.collectionView.mj_footer resetNoMoreData];
            weakSelf.collectionView.mj_footer.hidden = NO;
            NSDictionary *dic = weakSelf.tagsList[tag];
            weakSelf.tag = dic[@"name"];
            [weakSelf getVideoDateWithPage:@"1"];
        };
        
        [self.collectionView addSubview:self.headView];
        
        self.headView.y = -JXHeight(140);
        self.collectionView.contentInset = UIEdgeInsetsMake(JXHeight(140), 0, 0, 0);
        [self.collectionView setContentOffset:CGPointMake(0, -JXHeight(130))];
        [self.collectionView addSubview:self.headView];
        
        self.collectionView.mj_header.ignoredScrollViewContentInsetTop = JXHeight(140);
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
                SVCVideoDetailViewController *targent = [[SVCVideoDetailViewController alloc] init];
                targent.videoID = self.dataList[indexPath.row].ID;
                [self.navigationController pushViewController:targent animated:YES];
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
    JXMovieOfStyleBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMovieOfStyleBigCell" forIndexPath:indexPath];
    JXProductModel *model = [JXProductModel new];
    model.title = self.dataList[indexPath.row].title;
    model.image = self.dataList[indexPath.row].imgurl;
    cell.model = model;
    cell.titleLab.textColor = [UIColor blackColor];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JXWidth(184), JXHeight(170));
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
