//
//  SVCPersonCenterViewController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <MJRefresh.h>
#import "SVCPersonCenterViewController.h"
#import "SVCNavigationController.h"
#import "SVCchangPasswordViewController.h"
#import "SVCinvateFriendsViewController.h"
#import "SVCRechargeVC.h"
#import "SVCPersoncenterHeaderView.h"
#import "SVCLoginViewController.h"
#import "centerCell.h"
#import "SVCbuttonClickCell.h"
#import "SVCShareTimeViewController.h"
#import "SVCAdvPoliciesViewController.h"

@interface SVCPersonCenterViewController ()<UITableViewDataSource , UITableViewDelegate , SVCbuttonClickCellProtocol , SVCPersoncenterHeaderViewProtocol>
{
    NSString *_userUid;
}
@property (nonatomic , weak)UITableView *maintableView;
//@property(nonatomic,weak)AppDelegate * HXDelegate;
@end

@implementation SVCPersonCenterViewController
- (UITableView *)maintableView
{
    if (!_maintableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, - kstatueHeight, kScreenWidth, kScreenHeight - kTabbarHeight + kstatueHeight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.bounces = NO;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tab registerNib:[UINib nibWithNibName:@"centerCell" bundle:nil] forCellReuseIdentifier:@"cell"];
         [tab registerNib:[UINib nibWithNibName:@"SVCbuttonClickCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
        [tab registerNib:[UINib nibWithNibName:@"SVCPersoncenterHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
        [self.view addSubview:tab];
        _maintableView = tab;
    }
    return _maintableView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self maintableView];
    SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
    _userUid = user.uid;
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(loginSuccess) name:@"login" object:nil];
    [notiCenter addObserver:self selector:@selector(logoutSuccess) name:@"logout" object:nil];
    [notiCenter addObserver:self selector:@selector(logoutSuccess) name:@"fail" object:nil];
    [notiCenter addObserver:self selector:@selector(rechargeSuc) name:@"rechargesuccess" object:nil];
    [notiCenter addObserver:self selector:@selector(shareSuc) name:@"shareSuccessed" object:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 5) {
        centerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        switch (indexPath.row) {
            case 0:
                [cell setupUIwithimageName:@"icon_huiyuanxufei" title:@"会员续费"];
                break;
            case 1:
                [cell setupUIwithimageName:@"广告投放_icon" title:@"广告投放"];
                break;
            case 2:
                [cell setupUIwithimageName:@"代理政策_icon" title:@"代理政策"];
                break;
            case 3:
                [cell setupUIwithimageName:@"icon_yaoqinghaoyou" title:@"邀请好友"];
                break;
            case 4:
                [cell setupUIwithimageName:@"icon_xiugaimima" title:@"修改密码"];
                break;
            default:
                break;
        }
        return cell;
    }else{
        SVCbuttonClickCell *CELL = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
        CELL.selectionStyle = 0;
        CELL.Vdelegate = self;
        return CELL;
    }
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SVCPersoncenterHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    headerView.Vdelegate = self;
    if (_userUid.length < 1) {
        [headerView setupHeaderUI:YES];
    }else{
        [headerView setupHeaderUI:NO];
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_userUid.length < 1) {
        [self gotoLogin];
        return;
    }
    switch (indexPath.row) {
        case 0:
            [self shipRecharge];
            break;
        case 1:
            [self gotoAdvPolicies];
            break;
        case 2:
            [self gotoAgent];
            break;
        case 3:
            [self inviteFriends];
            break;
        case 4:
            [self gotoChangepassWord];
            break;
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_userUid.length > 0) {
        return 6;
    }else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
          return 60;
    }else{
        if (_userUid.length > 0) {
            return 120;
        }
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
#pragma mark -->修改密码
- (void)gotoChangepassWord
{
    SVCchangPasswordViewController *changePasswordVC = [[SVCchangPasswordViewController alloc] init];
    if ([self token].length > 1) {
        changePasswordVC.type = @"1";
    }
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}
- (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
#pragma mark -->邀请好友
- (void)inviteFriends
{
    SVCinvateFriendsViewController *invateVC = [[SVCinvateFriendsViewController alloc] init];
    if ([self token].length > 1) {
        invateVC.type = @"1";
    }
    [self.navigationController pushViewController:invateVC animated:YES];
}
#pragma mark -->会员续费
- (void)shipRecharge
{
    SVCRechargeVC *friendVC = [[SVCRechargeVC alloc] init];
    [self.navigationController pushViewController:friendVC animated:YES];
}

#pragma mark -->分享页面
- (void)share
{
    SVCShareTimeViewController *shareVC = [[SVCShareTimeViewController alloc] init];
    if ([self token].length > 1) {
        shareVC.type = @"1";
    }
    [self.navigationController pushViewController:shareVC animated:YES];
}

-(void)gotoAdvPolicies{
    SVCAdvPoliciesViewController * targent = [[SVCAdvPoliciesViewController alloc] init];
    targent.isAdvPolicies = YES;
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)gotoAgent{
    SVCAdvPoliciesViewController *targent = [[SVCAdvPoliciesViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
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
            [weakSelf.maintableView reloadData];
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
    [self.maintableView reloadData];
}
- (void)logoutSuccess
{
     _userUid = @"";
     [self.maintableView reloadData];
}
- (void)rechargeSuc
{
    [self.maintableView reloadData];
}

- (void)shareSuc{
     [self.maintableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
@end
