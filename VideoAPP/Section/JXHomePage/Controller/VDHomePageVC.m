//
//  VDHomePageVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDHomePageVC.h"


// cell
#import "JXMovieOfStyleBigCell.h"
#import "JXMovieOfStyleSmallCell.h"
#import "JXKindCell.h"
#import "JXMovieOfStyleLikeCell.h"
#import "JXAdvCell.h"

// view
#import "JXHomePageHeadView.h"
#import "JXHomePageFootView.h"
#import "JXFocusImageView.h"
#import "JXSearchView.h"

// model
#import "JXKindModel.h"
#import "SVCVideoDetailModel.h"

// vc
#import "VDKindVC.h"
#import "VDJWPlayerVC.h"
#import "SVCVideoDetailViewController.h"
#import "VDCollectionListVC.h"

@interface VDHomePageVC ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
JXFocusImageViewDelegate>

@property (nonatomic, strong) JXFocusImageView *advScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) JXSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray<JXAdvModel*> *advList;
@property (nonatomic, strong) NSMutableArray *cateList;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation VDHomePageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.dataList) {
        [self getNetData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hexStringToColor:@"252628"];
    [self setUpCollectionView];
    [self setUpSearchView];
    [self getNetData];
}

-(void)getNetData
{
    //[WsHUD showHUDWithLabel:@"加载数据..." modal:YES timeoutDuration:20.0];
    [JXAFNetWorking method:@"/mobile/index/index" parameters:nil finished:^(JXRequestModel *obj) {
        //[WsHUD hideHUD];
        [self.collectionView.mj_header endRefreshing];
        self.cateList = [obj getResultDictionary][@"cate"];
        self.dataList = [obj getResultDictionary][@"list"];
        [self.advScrollView reloadWithModel:[JXAdvModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"advList"]].mutableCopy];
        NSLog(@"%@",obj);
        self.advList = [JXAdvModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"advList"]].mutableCopy;
        [self.collectionView reloadData];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)setUpSearchView {
    self.searchView = [JXSearchView getViewFormNSBunld];
    self.searchView.frame = CGRectMake(0, 0, SCR_WIDTH, 44);
    self.navigationItem.titleView = self.searchView;
    [self.searchView.searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_search)]];
    [self.searchView.shareBtn addTarget:self action:@selector(goToShare) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView.uploadBtn addTarget:self action:@selector(goToUpload) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView.collection addTarget:self action:@selector(goToCollection) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goToShare
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil || token.length == 0) {
        SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
        SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    SVCinvateFriendsViewController *chargeVC = [[SVCinvateFriendsViewController alloc] init];
    [self.navigationController pushViewController:chargeVC animated:YES];
}

-(void)goToUpload
{
    self.tabBarController.selectedIndex = 2;
}

-(void)goToCollection
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil || token.length == 0) {
        
        SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
        SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    VDCollectionListVC *vc = [[VDCollectionListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setUpCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0 ;
    layout.minimumLineSpacing = 0 ;
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Tabbar_HEIGHT-Nav_HEIGHT);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXMovieOfStyleBigCell" bundle:nil] forCellWithReuseIdentifier:@"JXMovieOfStyleBigCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXMovieOfStyleSmallCell" bundle:nil] forCellWithReuseIdentifier:@"JXMovieOfStyleSmallCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXKindCell" bundle:nil] forCellWithReuseIdentifier:@"JXKindCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXMovieOfStyleLikeCell" bundle:nil] forCellWithReuseIdentifier:@"JXMovieOfStyleLikeCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXAdvCell" bundle:nil] forCellWithReuseIdentifier:@"JXAdvCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXHomePageHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXHomePageHeadView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXHomePageFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"JXHomePageFootView"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor hexStringToColor:@"252628"];
    [self.view addSubview:self.collectionView];
    
    CGRect advScrollViewrect = CGRectMake(0, JXHeight(20), SCR_WIDTH, JXHeight(190));
    self.advScrollView = [[JXFocusImageView alloc] initWithFrame:advScrollViewrect];
    self.advScrollView.JXDelegate = self;
    self.advScrollView.y = -JXHeight(190);
    [self.collectionView addSubview:self.advScrollView];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(JXHeight(190), 0, 0, 0);
    [self.collectionView setContentOffset:CGPointMake(0, -JXHeight(190))];
    [self.collectionView addSubview:self.advScrollView];
    
    SVCWeakSelf;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getNetData];
    }];
    
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = JXHeight(190);
    //    self.collectionView.mj_header.y = -JXHeight(235);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1+self.dataList.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.cateList.count;
    }else{
        NSDictionary *tmp = self.dataList[section-1];
        if ([tmp[@"type"] isEqualToString:@"猜你喜欢"] ||
            [tmp[@"type"] isEqualToString:@"广告"]) {
            return 1;
        }else{
            NSArray* tmpAry = tmp[@"list"];
            return tmpAry.count;
        }
    }
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        VDKindVC *targent = [[VDKindVC alloc] init];
        targent.title = @"影片检索";
        JXKindModel *model = [[JXKindModel alloc] initWithDictionary:self.cateList[indexPath.row] error:nil];
        targent.cate = model.title;
        [self.navigationController pushViewController:targent animated:YES];
    }else{
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        if (token==nil || token.length == 0) {
            SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
            SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        
        NSString *ID = @"";
        NSDictionary *tmp = self.dataList[indexPath.section-1];
        if ([tmp[@"type"] isEqualToString:@"最新"]) {
            NSArray *tmpAry = tmp[@"list"];
            JXProductModel *model = [[JXProductModel alloc ]initWithDictionary:tmpAry[indexPath.row] error:nil];
            ID = model.id;
        }
        else if ([tmp[@"type"] isEqualToString:@"重磅"]) {
            NSArray *tmpAry = tmp[@"list"];
            JXProductModel* model = [[JXProductModel alloc ]initWithDictionary:tmpAry[indexPath.row] error:nil];
            ID = model.id;
        }
        else if ([tmp[@"type"] isEqualToString:@"专题"]) {
            NSArray *tmpAry = tmp[@"list"];
            JXProductModel *model = [[JXProductModel alloc ]initWithDictionary:tmpAry[indexPath.row] error:nil];
            ID = model.id;
        }
        
        if (self.isSelectedCell == NO) {
            self.isSelectedCell = YES;
            
            [SVCCommunityApi checkVIPWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
                if (code == 0) {
                    SVCVideoDetailViewController *targent = [[SVCVideoDetailViewController alloc] init];
                    targent.videoID = ID ;
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
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        JXKindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXKindCell" forIndexPath:indexPath];
        cell.model = [[JXKindModel alloc] initWithDictionary:self.cateList[indexPath.row] error:nil];
        return cell;
    }else {
        NSDictionary *tmp = self.dataList[indexPath.section-1];
        if ([tmp[@"type"] isEqualToString:@"最新"]) {
            JXMovieOfStyleBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMovieOfStyleBigCell" forIndexPath:indexPath];
            NSArray *tmpAry = tmp[@"list"];
            cell.model = [[JXProductModel alloc ]initWithDictionary:tmpAry[indexPath.row] error:nil];
            return cell;
        }else if ([tmp[@"type"] isEqualToString:@"猜你喜欢"]) {
            JXMovieOfStyleLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMovieOfStyleLikeCell" forIndexPath:indexPath];
            cell.titleLab.text = tmp[@"title"];
            cell.list = tmp[@"list"];
            return cell;
        }
        else if ([tmp[@"type"] isEqualToString:@"广告"]) {
            JXAdvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXAdvCell" forIndexPath:indexPath];
            cell.model = [[JXAdvModel alloc] initWithDictionary:tmp error:nil];
            return cell;
        }
        else if ([tmp[@"type"] isEqualToString:@"重磅"]) {
            JXMovieOfStyleBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMovieOfStyleBigCell" forIndexPath:indexPath];
            NSArray *tmpAry = tmp[@"list"];
            cell.model = [[JXProductModel alloc ]initWithDictionary:tmpAry[indexPath.row] error:nil];
            return cell;
        }
        else if ([tmp[@"type"] isEqualToString:@"专题"]) {
            JXMovieOfStyleBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMovieOfStyleBigCell" forIndexPath:indexPath];
            //JXMovieOfStyleSmallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMovieOfStyleSmallCell" forIndexPath:indexPath];
            NSArray *tmpAry = tmp[@"list"];
            cell.model = [[JXProductModel alloc ]initWithDictionary:tmpAry[indexPath.row] error:nil];
            return cell;
        }
    }
    return [UICollectionViewCell new];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(JXWidth(85), JXHeight(85));
    }else{
        NSDictionary *tmp = self.dataList[indexPath.section-1];
        NSLog(@" type %@ ",tmp[@"type"]);
        if ([tmp[@"type"] isEqualToString:@"最新"]) {
            return CGSizeMake(JXWidth(184), JXHeight(170));
        }else if ([tmp[@"type"] isEqualToString:@"猜你喜欢"]) {
            return CGSizeMake(JXWidth(375), JXHeight(260));
        }
        else if ([tmp[@"type"] isEqualToString:@"广告"]) {
            return CGSizeMake(JXWidth(375), JXHeight(230));
        }
        else if ([tmp[@"type"] isEqualToString:@"重磅"]) {
            return CGSizeMake(JXWidth(184), JXHeight(173));
        }
        else if ([tmp[@"type"] isEqualToString:@"专题"]) {
            //return CGSizeMake(JXWidth(122), JXHeight(200));
            return CGSizeMake(JXWidth(184), JXHeight(173));
        }
    }
    return CGSizeMake(JXWidth(166), JXHeight(210));
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, JXWidth(7), 0, JXWidth(7));
    }else{
        NSDictionary *tmp = self.dataList[section-1];
        if ([tmp[@"type"] isEqualToString:@"最新"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }else if ([tmp[@"type"] isEqualToString:@"猜你喜欢"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        else if ([tmp[@"type"] isEqualToString:@"广告"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        else if ([tmp[@"type"] isEqualToString:@"重磅"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        else if ([tmp[@"type"] isEqualToString:@"专题"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
}



- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCR_WIDTH, JXHeight(10));
}


/// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) { // 分类
        return CGSizeMake(JXWidth(0), JXHeight(0));
    }else{
        NSDictionary *tmp = self.dataList[section-1];
        if ([tmp[@"type"] isEqualToString:@"最新"]) {
            return CGSizeMake(JXWidth(375), JXHeight(50));
        }else if ([tmp[@"type"] isEqualToString:@"猜你喜欢"]) {
            return CGSizeMake(JXWidth(375), JXHeight(0));
        }
        else if ([tmp[@"type"] isEqualToString:@"广告"]) {
            return CGSizeMake(JXWidth(375), JXHeight(0));
        }
        else if ([tmp[@"type"] isEqualToString:@"重磅"]) {
            return CGSizeMake(JXWidth(184), JXHeight(50));
        }
        else if ([tmp[@"type"] isEqualToString:@"专题"]) {
//            return CGSizeMake(JXWidth(122), JXHeight(50));
            return CGSizeMake(JXWidth(184), JXHeight(50));
        }
    }
    return CGSizeMake(JXWidth(166), JXHeight(210));
}

// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        // 底部视图
        JXHomePageHeadView *tempHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXHomePageHeadView" forIndexPath:indexPath];
        if (indexPath.section > 0) {
            NSDictionary *tmp = self.dataList[indexPath.section-1];
            tempHeaderView.titleLab.text = tmp[@"title"];
            tempHeaderView.moreBtn.tag = indexPath.section;
            [tempHeaderView.moreBtn addTarget:self action:@selector(click_headMore:) forControlEvents:UIControlEventTouchUpInside];
        }
        reusableView = tempHeaderView;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 底部视图
        JXHomePageFootView *tempHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"JXHomePageFootView" forIndexPath:indexPath];
        tempHeaderView.backgroundColor = [UIColor blackColor];
        if (indexPath.section <= 0) {
            tempHeaderView.backgroundColor = [UIColor clearColor];
        }
        reusableView = tempHeaderView;
    }
    return reusableView;
}

-(void)click_headMore:(UIButton*)btn
{
    NSDictionary *tmp = self.dataList[btn.tag-1];
    if ([tmp[@"type"] isEqualToString:@"重磅"]) {
        VDKindVC *targent = [[VDKindVC alloc] init];
        targent.sort = @"精彩推荐";
        [self.navigationController pushViewController:targent animated:YES];
    }
    else if ([tmp[@"type"] isEqualToString:@"专题"]) {
        VDKindVC *targent = [[VDKindVC alloc] init];
        targent.cate = tmp[@"title"];
        targent.cateID =  tmp[@"themeID"];
        //        targent.hiddenHeadView = YES;
        targent.title = tmp[@"title"];
        [self.navigationController pushViewController:targent animated:YES];
    }
}

-(void)JXFocusImageViewClick_img:(NSInteger)subIndex
{
    NSURL *url = [NSURL URLWithString:self.advList[subIndex].url];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication]openURL:url];
    }
}

-(void)click_search{
    SVCSearchViewController *targent = [[SVCSearchViewController alloc] init];
    targent.typeStr = @"0";
    [self.navigationController pushViewController:targent animated:YES];
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
