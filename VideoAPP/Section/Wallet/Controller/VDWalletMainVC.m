//
//  VDWalletMainVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDWalletMainVC.h"

#import "VDWalletMainView.h"

#import "VDWalletOfBindCardVC.h"
#import "VDWalletOfGetMoneyVC.h"
#import "VDWalletOfOrderListVC.h"
#import "VDWalletOfDetailListVC.h"


@interface VDWalletMainVC ()

@property (nonatomic, strong) VDWalletMainView *mainView;
@property (nonatomic, strong) NSDictionary * payInfoDic;
@property (nonatomic, assign) NSInteger code;
@end

@implementation VDWalletMainVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self getPayAccount];
    [self getNetData];
    [self.navigationController.navigationBar setBarTintColor: Color(255, 255, 255)];
    // 导航栏标题字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor hexStringToColor:@"ffffff"]};
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 5, 50, 25);
    btn.titleLabel.font = FontSize(15);
    [btn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [btn setTintColor:[UIColor hexStringToColor:@"cba677"]];
    //        [btn jx_setImageWithimgName:@"back"];
    //        [btn setTitle:@" " forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 10);
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
    
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"我的钱包";
    [self setUpMainView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"393F4B" andAlpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self setupNav];
    [self getNetData];
    [self getPayAccount];
}

-(void)getNetData{
    [JXAFNetWorking method:@"/mobile/user/wallt" parameters:nil finished:^(JXRequestModel *obj) {
        self.mainView.moneyLab.text = [NSString stringWithFormat:@"%@",[obj getResultDictionary][@"money"]];
    } failed:^(JXRequestModel *obj) {
        
    }];
}

-(void)getPayAccount{
    [JXAFNetWorking get:@"/mobile/user/apply" parameters:nil finished:^(JXRequestModel *obj) {
        NSLog(@"%@",obj);
        self.payInfoDic = [obj getResultDictionary];
        self.code = 1;
    } failed:^(JXRequestModel *obj) {
        [[UIApplication sharedApplication].keyWindow.rootViewController.view hideToasts];
        self.code = obj.code.integerValue;
    }];
}

- (void)setupNav{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"收入明细" forState:UIControlStateNormal];
    backBtn.titleLabel.font = FontSize(14);
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 15, 40, 30);
    [backBtn addTarget:self action:@selector(click_Detaillist) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)setUpMainView{
    self.mainView = [VDWalletMainView getViewFormNSBunld];
    self.mainView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    [self.mainView.getMoneyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_getMoney)]];
    [self.mainView.orderList addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_orderList)]];
    [self.mainView.setAccount addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_setAccount)]];
    [self.view addSubview:self.mainView];
}

-(void)click_getMoney{
    NSDictionary *payType = self.payInfoDic[@"list"];
    NSDictionary *alipayDIC = payType[@"alipay"];
    NSDictionary *wxpayDIC = payType[@"wxpay"];
    
    if (self.payInfoDic == nil && self.code != -1) {
        [self getPayAccount];
        [self.view toastShow:@"正在获取支付账号"];
        return;
    }
    if (alipayDIC.allKeys.count == 0 || wxpayDIC.allKeys.count == 0 || self.code == -1) {
        WS(weakSelf);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"未设置提现账户"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* shareAction = [UIAlertAction actionWithTitle:@"设置提现账户" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * action) {
            [weakSelf click_setAccount];
        }];
        
        
        UIAlertAction* okeyAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * action) {
        }];
        [alert addAction:okeyAction];
        [alert addAction:shareAction];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    VDWalletOfGetMoneyVC *targent = [[VDWalletOfGetMoneyVC alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)click_orderList{
    VDWalletOfOrderListVC *targent = [[VDWalletOfOrderListVC alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)click_setAccount{
    VDWalletOfBindCardVC *targent = [[VDWalletOfBindCardVC alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)click_Detaillist{
    VDWalletOfDetailListVC *targent = [[VDWalletOfDetailListVC alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}


@end
