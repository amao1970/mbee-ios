//
//  SVCSearchViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/8.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCSearchViewController.h"
#import "SVCHomePageSearchBar.h"
#import "SVCHomePageTableView.h"
#import "SVCPlayerViewController.h"

#import "SVCSearchHotListView.h"

// model
#import "SVCHomePageModel.h"
#import "SVCSearchHotListModel.h"

// vc
#import "SVCTextReadViewController.h"
#import "SVCRechargeVC.h"
#import "SVCVideoDetailViewController.h"
#import "SVCMoviePlayerViewController.h"

// view
#import "SVCSearchHeadView.h"


@interface SVCSearchViewController ()<SVCHomePageTableViewDelegate>

@property (nonatomic,strong) SVCHomePageSmallSearchBar *searchBar;
@property (nonatomic, strong) SVCHomePageTableView *tableView;

@property (nonatomic, strong) SVCSearchHotListView *hotListView;

@property (nonatomic,strong) NSArray<SVCHomePageModel*> *searchAry;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) NSArray *tmpAry;

@end

@implementation SVCSearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
    if (!self.searchAry.count && !self.searchInfo) {
        [self.searchBar.textFeild becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tmpAry = @[@"视频",@"影视"];
    self.type = @"2";
    self.view.backgroundColor = [UIColor hexStringToColor:@"1F2124"];
    [self setUpSearchBar];
    [self setUpSelectView];
    [self setUpTableView];
    
    if (self.searchInfo) {
        UIButton *btn = [UIButton new];
        btn.tag = [self.searchInfo[@"type"] integerValue];
        [self select_type:btn];
        self.searchBar.textFeild.text = self.searchInfo[@"content"];
        [self getNetData];
    }else{
        if (self.typeStr) {
            UIButton *btn = [UIButton new];
            btn.tag = self.typeStr.integerValue+1;
            [self select_type:btn];
        }
        [self getHotList];
    }
}

-(void)getHotList{
    NSString *type = self.type;
    if ([self.type isEqualToString:@"2"]) {
        type = @"3";
    }else if([self.type isEqualToString:@"3"]){
        type = @"4";
    }
    NSDictionary *dic = @{@"type":type};
    [SVCCommunityApi getSearchHotListWithParams:dic BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSMutableArray<SVCSearchHotListModel*> *tmpAry = [SVCSearchHotListModel mj_objectArrayWithKeyValuesArray:JSON[@"lists"]];
            self.hotListView.dataAry = tmpAry;
        }
        [WsHUD hideHUD];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
    }];
}

#pragma mark -- searchBar
-(void)setUpSearchBar{
    float height = JXHeight(50);
    self.searchBar = (SVCHomePageSmallSearchBar*)[[NSBundle mainBundle] loadNibNamed:
                      @"SVCHomePageSearchBar" owner:nil options:nil ].firstObject;
    self.searchBar.frame = CGRectMake(0, Nav_HEIGHT - 44, SCREEN_WIDTH, height);
    [self.searchBar.back addTarget:self action:@selector(click_back) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBar.search addTarget:self action:@selector(click_search) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBar.type addTarget:self action:@selector(show_selectView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchBar];
    
    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, 0, SCR_WIDTH, Nav_HEIGHT - 44 + height);
    headView.backgroundColor = self.searchBar.backgroundColor;
    [self.view addSubview:headView];
    [self.view sendSubviewToBack:headView];
}

-(void)setUpSelectView{
    self.selectView = [UIView new];
    self.selectView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    self.selectView.userInteractionEnabled = YES;
    self.selectView.alpha = 0;
    self.selectView.backgroundColor = [UIColor colorWithHexString:@"000000" andAlpha:0.2];
    [self.selectView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden_selectView)]];
    
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(self.searchBar.bgView.X, self.searchBar.bottom-JXHeight(5), self.searchBar.type.width, JXHeight(35)*3);
    [self.selectView addSubview:bgView];
    
    
    
    for (NSInteger i = 0; i<self.tmpAry.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, JXHeight(35)*i, bgView.width, JXHeight(35));
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor hexStringToColor:@"333333"] forState:UIControlStateNormal];
        [btn setTitle:self.tmpAry[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(select_type:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        [bgView addSubview:btn];
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 0, btn.width, 0.5);
        line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5" andAlpha:1];
        [btn addSubview:line];
    }
    
    [self.view addSubview:self.selectView];
    [self.view bringSubviewToFront:self.selectView];
}

#pragma mark -- setUpMainView
-(void)setUpTableView{
    float Y =  Nav_HEIGHT - 44 + JXHeight(50);
    CGRect rect = CGRectMake(0, Y, SCREEN_WIDTH, SCREEN_HEIGHT - Y);
    self.tableView = [[SVCHomePageTableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.JXDelegate = self;
    self.tableView.hidden = YES;
    self.tableView.hiddenLiveView = YES;
    [self.view addSubview:self.tableView];
    
    SVCSearchHeadView *hotHeadView = [SVCSearchHeadView getViewFormNSBunld];
    hotHeadView.frame = CGRectMake(0, -JXHeight(50), SCR_WIDTH, JXHeight(50));
    hotHeadView.userInteractionEnabled = YES;
    [hotHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_reload)]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, (IsIphone5a5c5s?JXWidth(0.9):JXWidth(1)), 0, 0);
    layout.minimumInteritemSpacing = 0 ;
    layout.minimumLineSpacing = 0 ;
    self.hotListView = [[SVCSearchHotListView alloc] initWithFrame:self.tableView.frame collectionViewLayout:layout];
    self.hotListView.backgroundColor = [UIColor whiteColor];
    SVCWeakSelf;
    self.hotListView.didSelectBlack = ^(NSInteger index) {
        UIButton *btn = [UIButton new];
        if ([weakSelf.hotListView.dataAry[index].cate isEqualToString:@"ysgl"]) {
            btn.tag = 3;
        }else if ([weakSelf.hotListView.dataAry[index].cate isEqualToString:@"video"]) {
            btn.tag = 2;
        }else{
            btn.tag = 1;
        }
        [weakSelf select_type:btn];
        weakSelf.searchBar.textFeild.text = weakSelf.hotListView.dataAry[index].name;
        [weakSelf getNetData];
    };
    [self.view addSubview:self.hotListView];
    [self.view bringSubviewToFront:self.hotListView];
    
    self.hotListView.contentInset = UIEdgeInsetsMake(hotHeadView.height, 0, 0, 0);
    [self.hotListView addSubview:hotHeadView];
    [self.hotListView setContentOffset:CGPointMake(0, -hotHeadView.height)];
}

-(void)click_reload{
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    [self getHotList];
}

-(void)getNetData{
    if (!self.searchBar.textFeild.text.length) {
        [self.view toastShow:@"请输入搜索内容"];
        return;
    }
    [self.view endEditing:NO];
    NSString *type = self.type;
//    if ([self.type isEqualToString:@"2"]) {
        type = @"3";
//    }else if([self.type isEqualToString:@"3"]){
//        type = @"4";
//    }
    NSDictionary *dic = @{
                          @"keywords":self.searchBar.textFeild.text
                          };
    self.searchBar.search.userInteractionEnabled = NO;
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    [SVCCommunityApi getSearchDataWithParams:dic BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        if (code == 0) {
            NSArray<SVCHomePageModel*> *tmpAry = [SVCHomePageModel mj_objectArrayWithKeyValuesArray:json[@"lists"]];
            [self.tableView reloadDataWithArray:tmpAry];
            self.searchAry = tmpAry;
            if (!tmpAry.count) {
                [self.searchBar.textFeild resignFirstResponder];
            }
            self.hotListView.hidden = YES;
            self.tableView.hidden = NO;
            NSLog(@"-----------");
        }
        [WsHUD hideHUD];
        self.searchBar.search.userInteractionEnabled = YES;
    } andfail:^(NSError *error) {
        self.searchBar.search.userInteractionEnabled = YES;
        [WsHUD hideHUD];
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
            SVCHomePageModel* model = self.searchAry[indexPath.row];
            if(model.type.integerValue <= 5){
                SVCTextReadViewController *vc = [[SVCTextReadViewController alloc] initWithNovelID:model.ID];
                if (model.type.integerValue > 3 && model.type.integerValue < 6) {
                    vc.isImg = YES;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                if ([self.type isEqualToString:@"3"]) {
                    SVCMoviePlayerViewController *vc = [[SVCMoviePlayerViewController alloc] initWithMovieURL:model.pingtai];
                    vc.title = model.title;
                    [self.navigationController pushViewController:vc animated:YES];
                    return ;
                }
                
                SVCVideoDetailViewController *targent = [[SVCVideoDetailViewController alloc] init];
                targent.videoID = model.ID;
                [self.navigationController pushViewController:targent animated:YES];
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

-(void)click_back{
    [self.view endEditing:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 搜索结果
-(void)click_search{
    NSLog(@"search");
    [self getNetData];
}

-(void)hidden_selectView{
    [UIView animateWithDuration:0.3 animations:^{
        self.selectView.alpha = 0;
    }];
}

-(void)show_selectView{
    [UIView animateWithDuration:0.3 animations:^{
        self.selectView.alpha = 1;
    }];
    [self.view bringSubviewToFront:self.selectView];
}

-(void)select_type:(UIButton*)btn{
    [self hidden_selectView];
    self.type = [NSString stringWithFormat:@"%ld",btn.tag];
    [self.searchBar.type setTitle:self.tmpAry[btn.tag-1] forState:UIControlStateNormal];
}

//支持旋转
- (BOOL)shouldAutorotate{
    return YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
