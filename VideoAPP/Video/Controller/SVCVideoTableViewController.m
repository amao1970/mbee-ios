//
//  SVCVideoTableViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/11/22.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCVideoTableViewController.h"
#import "SVCNovelTableViewCell.h"
#import "SVCVideoDetailModel.h"
#import "SVCTextReadViewController.h"
#import "SVCVideoTableViewCell.h"
#import <MJRefresh.h>
#import "AFHTTPSessionManager.h"
#import "SVCRechargeVC.h"
#import "SVCPlayerViewController.h"
#import "SVCVideoDetailViewController.h"

@interface SVCVideoTableViewController ()
@property(nonatomic, strong) NSMutableArray *dataList; /**<<#属性#> */
@property(nonatomic, copy) NSString *categoryID; /**<<#属性#> */
@property(nonatomic, copy) NSString *page; /**<<#属性#> */
@property(nonatomic, copy) NSString *pageNum; /**<<#属性#> */

@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */
@end

@implementation SVCVideoTableViewController

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
    self.pageNum = @"10";
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - Knavheight - GetHeightByScreenHeigh(45) - kTabbarHeight + 44);
    self.tableView.backgroundColor = SVCMarginColorf5;
    self.tableView.separatorColor = SVCMarginColorf5;
    
    [self getNovelWithID:_categoryID page:self.page];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_footer.hidden = YES;
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_header beginRefreshing];
        [weakSelf getNovelWithID:weakSelf.categoryID page:@"1"];
    }];
}

- (void)getNovelWithID:(NSString *)ID page:(NSString *)page{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:ID forSafeKey:@"cate_id"];
    [params setSafeObject:page forSafeKey:@"page"];
    [params setSafeObject:self.pageNum forSafeKey:@"limit"];
    [SVCCommunityApi getVideoListWithParams:params BlockSuccess:^(NSInteger code, NSString *msg, NSArray *json) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (code == 0) {
            if (page.integerValue == 1) {
                [self.dataList removeAllObjects];
            }
            
            self.page = [NSString stringWithFormat:@"%ld",self.page.integerValue + 1];
            NSArray *tmpList = [SVCVideoDetailModel mj_objectArrayWithKeyValuesArray:json];
            [self.dataList addObjectsFromArray:tmpList];
            if (tmpList.count < self.pageNum.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            [self.tableView reloadData];
        }
    } andfail:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMore{
    [self getNovelWithID:_categoryID page:self.page];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SVCVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SVCVideoTableViewCell" owner:nil options:nil] lastObject];
        [cell setUpVideoModel:self.dataList[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SVCVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SVCVideoTableViewCell" owner:nil options:nil] lastObject];
        ;
    }
    return [cell setUpVideoModel:self.dataList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
                targent.videoInfo = self.dataList[indexPath.row];
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
