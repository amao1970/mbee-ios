//
//  SVCHomePageViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/6.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageViewController.h"
#import "SVCHomePageTableView.h"
#import "SVCHomePageTopView.h"
#import "SVCIndeModel.h"
#import <MJRefresh.h>
#import "SVCHomePageLiveView.h"
#import "SVCLiveModel.h"
#import "SVCHomePageSearchBar.h"
#import "SVCTextReadViewController.h"
#import "SVCliveTypeViewController.h"
#import "SVCLiveViewController.h"
#import "SVCSearchViewController.h"
#import "SVCPlayerViewController.h"
#import "SVCRechargeVC.h"
@interface SVCHomePageViewController ()<SVCHomePageTableViewDelegate>

@property (nonatomic,strong) SVCHomePageSearchBar *searchBar;
@property (nonatomic, strong) SVCHomePageTopView *topView;
@property (nonatomic, strong) SVCHomePageTableView *tableView;
@property (nonatomic,strong) NSMutableArray<SVCIndeModel*> *banDataAry;
@property (nonatomic,strong) NSArray<SVCHomePageModel*> *homePageAry;
@property (nonatomic,strong) NSMutableArray<SVCLiveModel*> *liveArray;

@end

@implementation SVCHomePageViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if (!self.liveArray.count) {
        [self liveListData];
    }
    if (!self.banDataAry.count) {
        [self getBannerListData];
    }
    if (!self.homePageAry.count) {
        [self getNetData];
    }
    
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar]; // 搜索bar
    [self setUpTableView];
    [self getNetData];
    [self getBannerListData];
    [self liveListData];
    [self checkUpdate];
    [NC addObserver:self selector:@selector(checkUpdate) name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark --> 检测版本更新
- (void)checkUpdate
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"app_Version=%@", app_Version);
    NSDictionary *param = @{@"version":app_Version,@"type":@2};
    WS(weakSelf);
    [SVCCommunityApi CheckUpdateWithNSDiction:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if ([JSON[@"is_update"] intValue] == 1) {
            [weakSelf showcheckUpdate:JSON[@"download_url"]];
        }
    } andfail:^(NSError *error) {
        
    }];
}
#pragma mark --> 提示是否需要更新
- (void)showcheckUpdate:(NSString *)url
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"强制更新" message:@"有新版本推出,前往更新" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }else{
            [self.view toastShow:@"请在后台设置强制更新地址"];
            [self checkUpdate];
        }
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -- searchBar
-(void)setUpSearchBar{
    float height = JXHeight(50);
    self.searchBar = [SVCHomePageSearchBar getViewFormNSBunld];
    self.searchBar.frame = CGRectMake(0, Nav_HEIGHT - 44, SCREEN_WIDTH, height);
    self.searchBar.type.userInteractionEnabled = NO;
    self.searchBar.textFeild.userInteractionEnabled = NO;
    [self.searchBar.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(pushToSearch)]];
//    [self.searchBar.back addTarget:self
//                            action:@selector(click_back)
//                  forControlEvents:UIControlEventTouchUpInside];
    [self.searchBar.search addTarget:self
                              action:@selector(pushToSearch)
                    forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.searchBar];
    
    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, 0, SCR_WIDTH, Nav_HEIGHT - 44 + height);
    headView.backgroundColor = self.searchBar.backgroundColor;
    [self.view addSubview:headView];
    [self.view sendSubviewToBack:headView];
}

#pragma mark -- setUpMainView
-(void)setUpTableView
{
    self.topView = [[SVCHomePageTopView alloc] init];
    self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kScreenWidth/2.0);

    WS(weakSelf)
    self.topView.adListClick = ^(NSInteger index) {
        NSString *str = weakSelf.banDataAry[index].link;
        if (!str.length) {
            return;
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    
    float Y = Nav_HEIGHT - 44 + JXHeight(50);
    CGRect rect = CGRectMake(0, Y, SCREEN_WIDTH, SCREEN_HEIGHT - Y);
    self.tableView = [[SVCHomePageTableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.JXDelegate = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header beginRefreshing];
        [weakSelf getNetData];
        [weakSelf getBannerListData];
        [weakSelf liveListData];
    }];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topView;
}

-(void)getNetData
{
    [SVCCommunityApi getHomePageDataWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        if (code == 0) {
            NSArray<SVCHomePageModel*> *tmpAry = [SVCHomePageModel mj_objectArrayWithKeyValuesArray:json[@"lists"]];
            self.homePageAry = tmpAry;
            [self.tableView reloadDataWithArray:tmpAry];
            NSLog(@"-----------");
        }
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)liveListData{
    WS(weakSelf);
    BKNetworkHelper *help = [BKNetworkHelper shareInstance];
    [help POST:[NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/live/livelist"] Parameters:nil Success:^(id responseObject) {
        NSArray *arr = responseObject[@"data"][@"lists"];
        if (weakSelf.liveArray.count > 0) {
            [weakSelf.liveArray removeAllObjects];
        }
        NSMutableArray<SVCLiveModel*> *tmpAry = [NSMutableArray array];
        self.liveArray = tmpAry;
        for (NSDictionary *dict in arr) {
            SVCLiveModel *model = [SVCLiveModel mj_objectWithKeyValues:dict];
            [tmpAry addObject:model];
        }
        weakSelf.tableView.liveView.dataAry = tmpAry;
        [self.tableView.mj_header endRefreshing];
    } Failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.view toastShow:netFailString];
    }];
}

-(void)getBannerListData{
    WS(weakSelf);
    [SVCCommunityApi GetBannerListWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        self.banDataAry = [NSMutableArray array];
        if (code == 0) {
            NSArray *arr = JSON[@"advList"];
            NSMutableArray *ImageArray = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                SVCIndeModel *model = [SVCIndeModel mj_objectWithKeyValues:dic];
                [weakSelf.banDataAry addObject:model];
                [ImageArray addObject:model.image];
            }
            self.topView.imageArr = ImageArray;
            self.topView.notice = JSON[@"notice"];
        }else{
            [weakSelf.view toastShow:msg];
        }
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [weakSelf.view toastShow:netFailString];
    }];
}

#pragma mark -- 点击
-(void)SVCHomePageTableViewDidSelect:(NSIndexPath *)indexPath
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil || token.length == 0) {
        SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
        SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    [SVCCommunityApi checkVIPWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            SVCHomePageModel* model = self.homePageAry[indexPath.row];
            if(model.type.integerValue <= 5){
                SVCTextReadViewController *vc = [[SVCTextReadViewController alloc] initWithNovelID:model.ID];
                if (model.type.integerValue > 3 && model.type.integerValue < 6) {
                    vc.isImg = YES;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                SVCPlayerViewController *vc = [[SVCPlayerViewController alloc] initWithVideoUrl:model.videourl];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (code == -1){
            // 不是vip 进入充值界面
            [self gotochargeVC:msg];
        }else if(code == -997){
            SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
            SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
    } andfail:^(NSError *error) {
        
    }];
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

-(void)SVCHomePageLiveDidSelect:(NSInteger)index
{
    self.tabBarController.selectedIndex = 1;
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    if (token==nil || token.length == 0) {
//        SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
//        SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:nav animated:YES completion:nil];
//        return;
//    }
//
//    if (index >= 3) {
//
//        SVCLiveViewController *targent = [[SVCLiveViewController alloc] init];
//        targent.hiddenHomeBtn = YES;
//        [self.navigationController pushViewController:targent animated:YES];
//
//        return;
//    }
//
//    [self pusuToLiveVc:index];
}

-(void)pusuToLiveVc:(NSInteger)index{
    SVCLiveModel *model = self.liveArray[index];
    SVCliveTypeViewController *vc = [[SVCliveTypeViewController alloc]init];
    vc.liveUrlStr = model.name;
    vc.title = model.title;
    vc.topTitle = model.title;
    vc.imageStr = model.img;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushToSearch{
    SVCSearchViewController *targent = [[SVCSearchViewController alloc] init];
    targent.typeStr = @"0";
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)click_back{
    [self.navigationController popViewControllerAnimated:YES];
}


//支持旋转
- (BOOL)shouldAutorotate{
    return YES;
}
//
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
