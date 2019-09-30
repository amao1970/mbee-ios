//
//  SVCRechargeVC.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCRechargeVC.h"
#import "SVCMineCell.h"
#import "SVCUserInfoHeadView.h"
#import "SVCHelpListModel.h"
#import "SVCHelpInfoViewController.h"

@interface SVCRechargeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<SVCHelpListModel*>* dataAry;
@property (nonatomic, strong) SVCUserInfoHeadView *headView;
@property (nonatomic, strong) NSString *is_online_buy;
@property (nonatomic, strong) NSString *month_url;
@property (nonatomic, strong) NSString *season_url;
@property (nonatomic, strong) NSString *year_url;
@property (nonatomic, strong) NSString *forever_url;
@end

@implementation SVCRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员续费";
    [self setUpMainView];
    [self getHelpList];
    [self getcustomerInfo];
    
}

-(void)setUpMainView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SVCMineCell" bundle:nil] forCellReuseIdentifier:@"SVCMineCell"];
    [self.view addSubview:self.tableView];
    
    self.headView = [SVCUserInfoHeadView getViewFormNSBunld];
    self.headView.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(390));
    [self.headView.rechargeBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    self.headView.monthView.userInteractionEnabled = YES;
    self.headView.quarterView.userInteractionEnabled = YES;
    self.headView.halfYearView.userInteractionEnabled = YES;
    self.headView.yearView.userInteractionEnabled = YES;
    self.headView.servierView.userInteractionEnabled = YES;
    [self.headView.servierView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_servier)]];
    [self.headView.monthView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_month)]];
    [self.headView.quarterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_quarter)]];
    [self.headView.halfYearView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_halfYear)]];
    [self.headView.yearView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_year)]];
    self.tableView.tableHeaderView = self.headView;
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

- (void)getcustomerInfo
{
    WS(weakSelf);
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    [SVCCommunityApi GetcustomerInfoWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            self.headView.serverLab.text = [JSON[@"contact"] isEqual:[NSNull new]] ? @"": JSON[@"contact"];
            self.is_online_buy = [NSString stringWithFormat:@"%@",JSON[@"is_online_buy"]];
            self.month_url = [JSON[@"month_url"] isEqual:[NSNull new]] ?  @"": JSON[@"month_url"];
            self.season_url = [JSON[@"season_url"] isEqual:[NSNull new]] ? @"" : JSON[@"season_url"];
            self.year_url = [JSON[@"year_url"] isEqual:[NSNull new]] ? @"" : JSON[@"year_url"];
            self.forever_url = [JSON[@"forever_url"] isEqual:[NSNull new]] ? @"" : JSON[@"forever_url"];
            self.headView.monthMoneyLab.attributedText = [self setUpMoney:JSON[@"month_money"]];
            self.headView.halfYearMoneyLab.attributedText = [self setUpMoney:JSON[@"year_money"]];
            self.headView.yearMoneyLab.attributedText = [self setUpMoney:JSON[@"forever_money"]];
            self.headView.quarterMoneyLab.attributedText = [self setUpMoney:JSON[@"season_money"]];
            if ([self.is_online_buy isEqualToString:@"1"]) {
                UIColor *color = Color(255, 251, 242);
                UIColor *borderColor = Color(299, 187, 126);
                self.headView.yearView.layer.borderColor = borderColor.CGColor;
                self.headView.yearView.backgroundColor = color;
                self.headView.halfYearView.layer.borderColor = borderColor.CGColor;
                self.headView.halfYearView.backgroundColor = color;
                self.headView.monthView.layer.borderColor = borderColor.CGColor;
                self.headView.monthView.backgroundColor = color;
                self.headView.quarterView.layer.borderColor = borderColor.CGColor;
                self.headView.quarterView.backgroundColor = color;
                self.headView.quarterOnLineView.hidden = NO;
                self.headView.monthOnLineView.hidden = NO;
                self.headView.halfYearOnLineView.hidden = NO;
                self.headView.yearOnLineView.hidden = NO;
                
            }
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVCHelpInfoViewController *targent = [[SVCHelpInfoViewController alloc] initWithMsgId:self.dataAry[indexPath.row].id];
    [self.navigationController pushViewController:targent animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVCMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVCMineCell"];
    cell.titleLab.text = self.dataAry[indexPath.row].title;
    [cell.icon setImage:[UIImage imageNamed:self.dataAry[indexPath.row].type.integerValue == 1 ? @"广播" : @"问题"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(0.5));
//    view.backgroundColor = Color(244, 245, 246);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return JXHeight(0.5);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (BOOL)checkLogin{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    BOOL ret = NO;
    if (token.length < 1) {
        //        WS(weakSelf);
        SVCLoginViewController *logVC = [[SVCLoginViewController alloc] init];
        SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
        [self presentViewController:nav animated:YES completion:nil];
        ret = YES;
    }
    return ret;
}

- (void)recharge
{
    if ([self checkLogin]) {
        return;
    }else{
        UITextField *cardNoTF = self.headView.passwordTF;
        WS(weakSelf);
        if (cardNoTF.text.length < 2) {
            [self.view endEditing:YES];
            [weakSelf.view toastShow:@"请验证您的卡密"];
            return;
        }
        [WsHUD showHUDWithLabel:@"兑换中..." modal:YES timeoutDuration:20.0];
        NSDictionary *parasmeter = @{@"cardno":cardNoTF.text};
        [self.view endEditing:YES];
        [SVCCommunityApi UserrechargefoWithNSDiction:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            [WsHUD hideHUD];
            if (code == 0) {
                [weakSelf.view toastShow:@"兑换成功"];
                SVCCurrUser *user = [SVCCurrUser mj_objectWithKeyValues:JSON];
                [SVCUserInfoUtil mSaveUser:user];
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"rechargesuccess" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view toastShow:msg];
            }
        } andfail:^(NSError *error) {
            [WsHUD hideHUD];
            [weakSelf.view toastShow:netFailString];
        }];
    }
}

-(void)click_month{
    [self rechargeViewDidclick:1206];
}

-(void)click_quarter{
    [self rechargeViewDidclick:1207];
}

-(void)click_halfYear{
    [self rechargeViewDidclick:1208];
}

-(void)click_year{
    [self rechargeViewDidclick:1209];
}

- (void)rechargeViewDidclick:(NSInteger)tag
{
    if ([self.is_online_buy isEqualToString:@"1"]) {
        switch (tag) {
            case 1206:
                [self openUrl:self.month_url];
                break;
            case 1207:
                [self openUrl:self.season_url];
                break;
            case 1208:
                [self openUrl:self.year_url];
                break;
            case 1209:
                [self openUrl:self.forever_url];
                break;
                
            default:
                break;
        }
    }else{
        [self showMessageAleartController:[NSString stringWithFormat:@"请联系客服购买卡密\n%@",self.headView.serverLab.text]];
    }
    
}
- (void)openUrl:(NSString *)url
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}
#pragma mark --> 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}

- (void)showMessageAleartController:(NSString *)msg
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)click_servier{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [self.view toastShow:@"已复制"];
    pasteboard.string = self.headView.serverLab.text;
}

-(NSMutableAttributedString*)setUpMoney:(NSString*)money{
    NSString *string = [@"¥" stringByAppendingFormat:@"%@",money];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    return attriStr;
}

@end
