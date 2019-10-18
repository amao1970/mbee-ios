//
//  SVCMineVC.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCMineVC.h"
#import "SVCMineHeadView.h"
#import "SVCMineCell.h"
#import "SVCMineHeadView.h"
#import "SVCHelpListModel.h"
#import "SVCMineCell.h"
#import "SVCUserInfoCell.h"
#import "SVCUserInfoVC.h"
#import "SVCRechargeVC.h"
#import "VDWalletMainVC.h"

#import "SVCAdvPoliciesViewController.h"
#import "SVCinvateFriendsViewController.h"
#import "SVCRechargeVC.h"
#import "SVCchangPasswordViewController.h"
#import "SVCHelpInfoViewController.h"

#import "VDUploadVideoListVC.h"
#import "VDCollectionListVC.h"
#import "VDAtentionListVC.h"

@interface SVCMineVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_userUid;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<SVCHelpListModel*>* dataAry;
@property (nonatomic, strong) SVCMineHeadView *headView;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSString *service;

@end

@implementation SVCMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setUpMainView];
    [self getHelpList];
    [self getServerData];
    [self reloadHeadView];
    self.service = @"";
    self.titleAry = @[@"修改密码",@"联系客服"];
    SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
    _userUid = user.uid;
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(loginSuccess) name:@"login" object:nil];
    [notiCenter addObserver:self selector:@selector(logoutSuccess) name:@"logout" object:nil];
    [notiCenter addObserver:self selector:@selector(logoutSuccess) name:@"fail" object:nil];
    [notiCenter addObserver:self selector:@selector(rechargeSuc) name:@"rechargesuccess" object:nil];
    [notiCenter addObserver:self selector:@selector(reloadHeadView) name:@"reloadHeadView" object:nil];
    [notiCenter addObserver:self selector:@selector(shareSuc) name:@"shareSuccessed" object:nil];
}

-(void)setUpMainView{
    
    float height = Nav_HEIGHT - 44;
    CGRect rect = CGRectMake(0, height, SCR_WIDTH, SCR_HIGHT - Tabbar_HEIGHT - height);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SVCUserInfoCell" bundle:nil] forCellReuseIdentifier:@"SVCUserInfoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SVCMineCell" bundle:nil] forCellReuseIdentifier:@"SVCMineCell"];
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadHeadView ];
    }];
    [self.view addSubview:self.tableView];
    
    self.headView = [SVCMineHeadView getViewFormNSBunld];
    self.headView.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(439));
    self.headView.userInteractionEnabled = YES;
    [self.headView.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUserInfoVC)]];
    [self.headView.headImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUserInfoVC)]];
    [self.headView.settingBtn addTarget:self action:@selector(goToUserInfoVC) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.rechargeBtn addTarget:self action:@selector(click_recharge) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.shareBtn addTarget:self action:@selector(click_share) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.delegateBtn addTarget:self action:@selector(click_delegate) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.advBtn addTarget:self action:@selector(click_adv) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.renewalBtn addTarget:self action:@selector(click_recharge) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.incomeLab addTarget:self action:@selector(click_income) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.worksLab addTarget:self action:@selector(click_works) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.FocusLab addTarget:self action:@selector(click_Focus) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.collectionLab addTarget:self action:@selector(click_collection) forControlEvents:UIControlEventTouchUpInside];
    [self.headView updateUIWithLogin:[self token].length>2];
    self.tableView.tableHeaderView = self.headView;
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(80));
    self.logoutBtn = [[UIButton alloc] init];
    self.logoutBtn.frame = CGRectMake(0, JXHeight(25), JXWidth(316), JXHeight(48));
    self.logoutBtn.backgroundColor = [UIColor hexStringToColor:@"bb8d56"];
    self.logoutBtn.centerX = SCR_WIDTH/2.f;
    self.logoutBtn.layer.cornerRadius = 8;
    self.logoutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logoutBtn addTarget:self action:@selector(LogoutClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:self.logoutBtn];
    self.tableView.tableFooterView = footView;
#ifdef iOS11
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
#endif
    if([self token].length <= 0){
        self.logoutBtn.hidden = YES;
    }
}

-(void)getServerData{
    WS(weakSelf);
    [SVCCommunityApi GetcustomerInfoWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            self.service = [JSON[@"contact"] isEqual:[NSNull new]] ? @"": JSON[@"contact"];
            [self.tableView reloadData];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}

-(void)getHelpList{
    WS(weakSelf);
    [SVCCommunityApi getHelpListWithParams:nil BlockSuccess:^(NSInteger code, NSString * msg, NSArray *json) {
        if (code == 0) {
            self.dataAry = [SVCHelpListModel arrayOfModelsFromDictionaries:json error:nil];
            [self.tableView reloadData];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SVCHelpInfoViewController *targent = [[SVCHelpInfoViewController alloc] initWithMsgId:self.dataAry[indexPath.row].id];
        [self.navigationController pushViewController:targent animated:YES];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if ([self token].length < 1) {
                [self gotoLogin];
                return;
            }
            SVCchangPasswordViewController *changePasswordVC = [[SVCchangPasswordViewController alloc] init];
            if ([self token].length > 1) {
                changePasswordVC.type = @"1";
            }
            [self.navigationController pushViewController:changePasswordVC animated:YES];
        }else{
            if (!self.service.length) {
                return;
            }
            
            NSURL *url = [NSURL URLWithString: self.service];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
            
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            [self.view toastShow:@"已复制"];
//            pasteboard.string = self.service;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataAry.count;
    }
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        SVCMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVCMineCell"];
        cell.titleLab.text = [NSString stringWithFormat:@"%@",self.dataAry[indexPath.row].title];
        [cell.icon setImage:[UIImage imageNamed: @"问题"]]; //self.dataAry[indexPath.row].type.integerValue == 1 ? @"广播" : @"问题"]];
        return cell;
    }
    else{
        SVCUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVCUserInfoCell"];
        cell.titleLab.text = self.titleAry[indexPath.row];
        cell.subtitleLab.text = @"";

//        if (indexPath.row == 1) {
//            cell.subtitleLab.text = self.service;
//        }else{
//            cell.subtitleLab.text = @"";
//        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(10));
    view.backgroundColor = Color(244, 245, 246);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataAry.count ? JXHeight(5) : JXHeight(0.5);
    }
    return JXHeight(5);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)goToUserInfoVC{
    if ([self token].length < 1) {
        [self gotoLogin];
        return;
    }
//    SVCRechargeVC *targent = [[SVCRechargeVC alloc] init];
    SVCUserInfoVC *targent = [[SVCUserInfoVC alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

#pragma mark --> 点击去登录
- (void)LoginClick
{
    [self gotoLogin];
}
#pragma mark -->登录
- (void)gotoLogin
{
    SVCLoginViewController *loginVC = [[SVCLoginViewController alloc] init];
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)gotoLogout
{
    WS(weakSelf);
    [SVCCommunityApi LogoutWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [SVCUserInfoUtil deleteFile];
            [SVCCurrUser deledateToken:@"token"];
            _userUid = @"";
            [weakSelf.tableView reloadData];
            [weakSelf gotoLogin];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    }];
}
- (void)loginSuccess
{
    _userUid = [SVCUserInfoUtil mGetUser].uid;
    [self getServerData];
    [self reloadHeadView];
    [self.headView updateUIWithLogin:YES];
    self.logoutBtn.hidden = NO;
    [self.tableView reloadData];
}
- (void)logoutSuccess
{
    _userUid = @"";
    self.service = @"";
    [self.headView updateUIWithLogin:NO];
    self.logoutBtn.hidden = YES;
    [self.tableView reloadData];
}
- (void)rechargeSuc
{
    [self.headView updateUIWithLogin:YES];
    [self reloadHeadView];
    [self.tableView reloadData];
}

- (void)shareSuc{
    [self.headView updateUIWithLogin:YES];
    [self reloadHeadView];
    [self.tableView reloadData];
}

-(void)click_income{
    VDWalletMainVC *vc = [[VDWalletMainVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)click_works{
    VDUploadVideoListVC *vc = [[VDUploadVideoListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)click_Focus{
    VDAtentionListVC *vc = [[VDAtentionListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)click_collection{
    VDCollectionListVC *vc = [[VDCollectionListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    [self reloadHeadView];
}

- (void)LogoutClick
{
    if (_userUid.length < 1) {
        return;
    }else{
        [self logoutClick];
    }
}
- (void)logoutClick
{
    WS(weakSelf);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                   message:@"您正在选择退出"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [weakSelf gotoLogout];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)click_recharge{
    if ([self token].length < 1) {
        [self gotoLogin];
        return;
    }
    SVCRechargeVC *friendVC = [[SVCRechargeVC alloc] init];
    [self.navigationController pushViewController:friendVC animated:YES];
}

-(void)click_share{
    if ([self token].length < 1) {
        [self gotoLogin];
        return;
    }
    SVCinvateFriendsViewController *invateVC = [[SVCinvateFriendsViewController alloc] init];
    if ([self token].length > 1) {
        invateVC.type = @"1";
    }
    [self.navigationController pushViewController:invateVC animated:YES];
}

-(void)click_delegate{
    if ([self token].length < 1) {
        [self gotoLogin];
        return;
    }
    SVCAdvPoliciesViewController *targent = [[SVCAdvPoliciesViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)click_adv{
    if ([self token].length < 1) {
        [self gotoLogin];
        return;
    }
    SVCAdvPoliciesViewController * targent = [[SVCAdvPoliciesViewController alloc] init];
    targent.isAdvPolicies = YES;
    [self.navigationController pushViewController:targent animated:YES];
}

- (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

// 获取用户信息
// 获取用户状态
-(void)reloadHeadView {
    [JXAFNetWorking method:@"/mobile/user/index" parameters:nil finished:^(JXRequestModel *obj) {
        NSDictionary *dic = [obj getResultDictionary];
        
        self.headView.renewalBtn.userInteractionEnabled = NO;
        self.headView.income.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
        self.headView.works.text = [NSString stringWithFormat:@"%@",dic[@"zuoping"]];
        self.headView.focus.text = [NSString stringWithFormat:@"%@",dic[@"guanzhu"]];
        self.headView.collection.text = [NSString stringWithFormat:@"%@",dic[@"shoucang"]];
        
        if ([dic[@"is_ever"] integerValue] == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.headView.renewalBtn setTitle:@"" forState:UIControlStateNormal];
            self.headView.renewalBtn.userInteractionEnabled = NO;
        } else {
            [JXAFNetWorking method:@"/mobile/index/checkUser" parameters:nil finished:^(JXRequestModel *obj) {
                [self.tableView.mj_header endRefreshing];
                NSDictionary *dicCheck = [obj getResultDictionary];
                [self.headView.renewalBtn setTitle: dicCheck[@"vip_content"] forState:UIControlStateNormal];
                self.headView.renewalBtn.userInteractionEnabled = NO;
            } failed:^(JXRequestModel *obj) {
                [self.tableView.mj_header endRefreshing];
                if (obj.code.integerValue == -1){
                    [self.headView.renewalBtn setTitle:@"请尽快续费" forState:UIControlStateNormal];
                    self.headView.renewalBtn.userInteractionEnabled = YES;
                }else if(obj.code.integerValue == -997){
                    [self logoutSuccess];
                }
            }];
        }
    } failed:^(JXRequestModel *obj) {
        [self.tableView.mj_header endRefreshing];
        if (obj.code.integerValue == -1){
            [self.headView.renewalBtn setTitle:@"请尽快续费" forState:UIControlStateNormal];
            self.headView.renewalBtn.userInteractionEnabled = YES;
        }else if(obj.code.integerValue == -997){
            [self logoutSuccess];
        }
    }];
}

/**
// 旧数据
-(void)reloadHeadView{
    NSLog(@"loading");
        [JXAFNetWorking method:@"/mobile/user/index" parameters:nil finished:^(JXRequestModel *obj) {
            [self.tableView.mj_header endRefreshing];
            NSDictionary *dic = [obj getResultDictionary];
            SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
            if ([dic[@"is_ever"] integerValue] == 1) {
                [self.tableView.mj_header endRefreshing];
                [self.headView.renewalBtn setTitle:@"" forState:UIControlStateNormal];
                self.headView.renewalBtn.userInteractionEnabled = NO;
            }else{
                if (!isNull([obj getResultDictionary][@"end_time"])) {
                    NSString *str = [NSString stringWithFormat:@"%@",dic[@"end_time"]];
                    user.end_time = str.length ? str : user.end_time;
                    [SVCUserInfoUtil mSaveUser:user];
                    [self.headView updateUIWithLogin:YES];
                }
                
                if ([[obj getResultDictionary][@"is_end"] integerValue] == 1) {
                    [self.headView.renewalBtn setTitle:@"请尽快续费" forState:UIControlStateNormal];
                }else{
                    [self.headView.renewalBtn setTitle:@"VIP生效中" forState:UIControlStateNormal];
                }
            }
            self.headView.renewalBtn.userInteractionEnabled = NO;
            self.headView.income.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
            self.headView.works.text = [NSString stringWithFormat:@"%@",dic[@"zuoping"]];
            self.headView.focus.text = [NSString stringWithFormat:@"%@",dic[@"guanzhu"]];
            self.headView.collection.text = [NSString stringWithFormat:@"%@",dic[@"shoucang"]];
        } failed:^(JXRequestModel *obj) {
            [self.tableView.mj_header endRefreshing];
            if (obj.code.integerValue == -1){
                // 不是会员
                [self.headView.renewalBtn setTitle:@"请尽快续费" forState:UIControlStateNormal];
                self.headView.renewalBtn.userInteractionEnabled = YES;
                self.headView.renewalBtn.width = [self.headView.renewalBtn.titleLabel sizeThatFits:self.headView.renewalBtn.titleLabel.size].width+20;
            }else if(obj.code.integerValue == -997){
                [self logoutSuccess];
            }
        }];
}
 */

- (NSDate *)getCurrentTime{
    //2017-04-24 08:57:29
    NSLocale * locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.locale = locale;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

- (BOOL)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return YES;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return NO;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return NO;
    
}

@end
