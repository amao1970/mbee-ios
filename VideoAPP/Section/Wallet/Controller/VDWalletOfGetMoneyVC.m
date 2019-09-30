//
//  VDWalletOfGetMoneyVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDWalletOfGetMoneyVC.h"
#import "VDWalletOfGetMoneyView.h"
#import "VDWalletOfBindCardVC.h"

@interface VDWalletOfGetMoneyVC ()

@property (nonatomic, strong) VDWalletOfGetMoneyView *mainView;
@property (nonatomic, strong) NSDictionary * payInfoDic;

@end

@implementation VDWalletOfGetMoneyVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.payInfoDic) {
        [self getPayAccount];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"提现";
    [self setUpMainView];
    [self getPayAccount];
}

-(void)setUpMainView{
    self.mainView = [VDWalletOfGetMoneyView getViewFormNSBunld];
    self.mainView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    [self.mainView.moneyTF becomeFirstResponder];
    [self.mainView.payAccount addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_payAccount)]];
    [self.mainView.commit addTarget:self action:@selector(click_commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mainView];
}

-(void)click_payAccount{
    VDWalletOfBindCardVC *targent = [[VDWalletOfBindCardVC alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)getPayAccount{
    [JXAFNetWorking get:@"/mobile/user/apply" parameters:nil finished:^(JXRequestModel *obj) {
        NSLog(@"%@",obj);
        self.payInfoDic = [obj getResultDictionary][@"list"];
        NSDictionary *alipayDIC = self.payInfoDic[@"alipay"];
        NSDictionary *wxpayDIC = self.payInfoDic[@"wxpay"];
        
        if (alipayDIC.allKeys.count && wxpayDIC.allKeys.count) {
            if ([wxpayDIC[@"isdefault"] boolValue]) {
                [self setUpValue:wxpayDIC payType:@"微信"];
            }else{
                [self setUpValue:alipayDIC payType:@"支付宝"];
            }
        }else if (alipayDIC.allKeys.count){
            [self setUpValue:alipayDIC payType:@"支付宝"];
        }else if (wxpayDIC.allKeys.count){
            [self setUpValue:wxpayDIC payType:@"微信"];
        }
        
        self.mainView.balanceLab.text = [NSString stringWithFormat:@"可用余额%@元",[obj getResultDictionary][@"money"]];
        self.mainView.minMoney.text = [NSString stringWithFormat:@"最小提现金额为%@元",[obj getResultDictionary][@"minmoney"]];
    } failed:^(JXRequestModel *obj) {
        if (obj.code.integerValue == -1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)setUpValue:(NSDictionary*)dic payType:(NSString*)type{
    self.mainView.payType.text = type;
    self.mainView.name.text = [NSString stringWithFormat:@"收款人: %@",dic[@"uname"]];
    [self.mainView.icon jx_setImageWithImageName:type];
}

-(void)click_commit{
//    money
//type:wxpay?alipay

    if ([self.mainView.moneyTF.text integerValue] < [self.payInfoDic[@"minmoney"] integerValue]) {
        [self.view toastShow:@"申请提现金额不能小于起提金额"];
        return;
    }
    NSDictionary *dic = @{@"money":self.mainView.moneyTF.text,
                          @"type":self.payInfoDic[@"paytype"]
                          };
    [WsHUD showHUDWithLabel:@"正在提交..." modal:YES timeoutDuration:20.0];
    [JXAFNetWorking method:@"/mobile/user/apply" parameters:dic finished:^(JXRequestModel *obj) {
        [self getPayAccount];
        [WsHUD hideHUD];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];
}

@end
