//
//  SVCLoginViewController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/8.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLoginViewController.h"
#import "SVCregistViewController.h"
#import "SVCPersonCenterViewController.h"
#import "SVCTabBarController.h"
#import "SVCforgerPasswordViewController.h"
#import "SVCunderLineTF.h"
#import "ToolClass.h"
@interface SVCLoginViewController ()<UITextFieldDelegate>
{
    SVCunderLineTF *_phoneNumTF;
    SVCunderLineTF *_passWordTF;
}
@end

@implementation SVCLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    [self setupUI];
    // Do any additional setup after loading the view.
}
#pragma mark --> 初始化UI
- (void)setupUI{

    _phoneNumTF = [[SVCunderLineTF alloc] init];
    _phoneNumTF.frame = CGRectMake(20, 60, kScreenWidth - 40, 40);
    _phoneNumTF.placeholder = @"请输入您的手机号码";
    _phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneNumTF];
    
    _passWordTF = [[SVCunderLineTF alloc] init];
    _passWordTF.frame = CGRectMake(20, CGRectGetMaxY(_phoneNumTF.frame)+20, kScreenWidth - 40, 40);
    _passWordTF.placeholder = @"请输入您的密码";
    _passWordTF.returnKeyType = UIReturnKeyDone;
    _passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWordTF.secureTextEntry = YES;
    _passWordTF.delegate = self;
    [self.view addSubview:_passWordTF];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *phoneNum = [ud objectForKey:@"phone_number"];
    NSString *phonePassword = [ud objectForKey:@"loginPassWord"];
    if (phoneNum.length > 6) {
        _phoneNumTF.text = phoneNum;
    }
    if (phonePassword.length > 4) {
        _passWordTF.text = phonePassword;
    }
    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forgetPasswordBtn.backgroundColor = [UIColor whiteColor];
        [forgetPasswordBtn setTitleColor:[UIColor hexStringToColor:@"666666"] forState:0];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
        [forgetPasswordBtn setTitle:@"忘记密码" forState:0];
    forgetPasswordBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetPasswordBtn.titleLabel.font = kFont(12);
        forgetPasswordBtn.frame = CGRectMake(kScreenWidth - 80, CGRectGetMaxY(_passWordTF.frame)+10, 60, 30);
    [self.view addSubview:forgetPasswordBtn];
    for (NSInteger i = 0; i < 2; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1206 + i;
        if (i == 0) {
            button.backgroundColor = BtnbgColor;
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:@"登 录" forState:0];
            button.frame = CGRectMake(20, CGRectGetMaxY(_passWordTF.frame)+60, kScreenWidth - 40, 45);
        }else{
            [button setTitle:@"注 册" forState:0];
             [button setTitleColor:BtnbgColor forState:0];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake(20, CGRectGetMaxY(_passWordTF.frame)+120, kScreenWidth - 40, 45);
            button.layer.borderColor = BtnbgColor.CGColor;
            button.layer.borderWidth = 1.0f;
        }
        button.layer.cornerRadius = 6.0;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}
#pragma mark --> 忘记密码
- (void)forgetPasswordClick
{
    SVCforgerPasswordViewController *forgetVC = [[SVCforgerPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
#pragma mark --> 登录按钮的点击
- (void)btnClick:(UIButton *)sender
{
    WS(weakSelf);
    if (sender.tag == 1206) {
        if (![self checkphoneNumber]) {
            return;
        }
        NSDictionary *parasmeter = @{@"username":_phoneNumTF.text,
                                     @"password":_passWordTF.text
                                     };
        [WsHUD showHUDWithLabel:@"登录中..." modal:YES timeoutDuration:20.0];
        [SVCCommunityApi LoginWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            [WsHUD hideHUD];
            if (code == 0 ) {
                 [SVCCurrUser SaveLoginInfoToken:JSON[@"token"] andPhoneNumber:_phoneNumTF.text andUserID:JSON[@"uid"] andPassword:_passWordTF.text andLoginType:@"login"];
                [weakSelf.view toastShow:@"登录成功"];
                [weakSelf returnBack];
            }else{
                [weakSelf.view toastShow:msg];
            }
        } andfail:^(NSError *error) {
            [WsHUD hideHUD];
            [weakSelf.view toastShow:netFailString];
        }];
    }else{
        SVCregistViewController *registVC = [[SVCregistViewController alloc] init];
        [self.navigationController pushViewController:registVC animated:YES];
    }
}
#pragma mark --> 验证电话号码格式
- (BOOL)checkphoneNumber
{
    if ([_phoneNumTF.text isEqualToString:@""]) {
         [self.view endEditing:YES];
        [self.view toastShow:@"请填写手机号码"];
        return NO;
    }else if (![ToolClass  isMobileNumber:_phoneNumTF.text]) {
         [self.view endEditing:YES];
        [self.view toastShow:@"手机号码错误，请重新输入"];
        return NO;
    }else if ([_phoneNumTF.text length] < 11 ||[_phoneNumTF.text length] > 11 ) {
         [self.view endEditing:YES];
        [self.view toastShow:@"请核对手机号码"];
        return NO;
    }else if (_passWordTF.text.length < 6){
         [self.view endEditing:YES];
        [self.view toastShow:@"请核对您的密码"];
        return NO;
    }else{
         [self.view endEditing:YES];
        return YES;
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

- (void)returnBack
{
    if (self.adLoginClick) {
        self.adLoginClick(1);
    }
    if ([self.type isEqualToString:@"1"]) {
         [self dismissViewControllerAnimated:YES completion:nil];
        SVCTabBarController *tab = (SVCTabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        [tab setSelectedIndex:0];
//        UIViewController *vc = self.presentingViewController;
//
//        [vc dismissViewControllerAnimated:YES completion:nil];

    }else{
         [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
