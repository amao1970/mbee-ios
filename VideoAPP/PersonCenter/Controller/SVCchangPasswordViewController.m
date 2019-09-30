//
//  SVCchangPasswordViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/8.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCchangPasswordViewController.h"
#import "SVCLoginViewController.h"
#import "SVCNavigationController.h"
#import "SVCunderLineTF.h"
@interface SVCchangPasswordViewController ()<UITextFieldDelegate >
{
    SVCunderLineTF *_phoneNumTF;
    SVCunderLineTF *_passWordTF;
    SVCunderLineTF *_inviteCodeTF;
    BOOL _isLog;
}

@end

@implementation SVCchangPasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"sgevee");
    if ([self.type isEqualToString:@"1"]) {
        [self checkLogin];
    }
    self.title = @"修改密码";
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (BOOL)checkLogin
{
    BOOL ret = NO;
//    SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token.length < 1 ) {
        SVCLoginViewController *logVC = [[SVCLoginViewController alloc] init];
        SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
//        logVC.Vdelegate = self;
        [self presentViewController:nav animated:YES completion:nil];
        ret = YES;
    }
    return ret;
}
- (void)confing{
    _isLog = YES;
}
#pragma mark --> 初始化UI
- (void)setupUI{
 
    _phoneNumTF = [[SVCunderLineTF alloc] init];
    _phoneNumTF.frame = CGRectMake(20, 66, kScreenWidth - 40, 40);
    _phoneNumTF.placeholder = @"请输入旧密码";
    _phoneNumTF.returnKeyType = UIReturnKeyDone;
    _phoneNumTF.secureTextEntry = YES;
    _phoneNumTF.delegate = self;
    [self.view addSubview:_phoneNumTF];
    
    _passWordTF = [[SVCunderLineTF alloc] init];
    _passWordTF.frame = CGRectMake(20, CGRectGetMaxY(_phoneNumTF.frame)+20, kScreenWidth - 40 , 40);
    _passWordTF.placeholder = @"请输入您的新密码";
    _passWordTF.secureTextEntry = YES;
    _passWordTF.returnKeyType = UIReturnKeyDone;
    _phoneNumTF.delegate = self;
    [self.view addSubview:_passWordTF];
    
    _inviteCodeTF = [[SVCunderLineTF alloc] init];
    _inviteCodeTF.frame = CGRectMake(20, CGRectGetMaxY(_passWordTF.frame)+20, kScreenWidth - 40, 40);
    _inviteCodeTF.placeholder = @"请再次输入您的新密码";
    _inviteCodeTF.secureTextEntry = YES;
    _inviteCodeTF.returnKeyType = UIReturnKeyDone;
    _inviteCodeTF.delegate = self;
    [self.view addSubview:_inviteCodeTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = BtnbgColor;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitle:@"完成" forState:0];
    button.frame = CGRectMake(20, CGRectGetMaxY(_inviteCodeTF.frame)+88, kScreenWidth - 40, 45);
    button.layer.cornerRadius = 6.0;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)btnClick:(UIButton *)sender
{
    if ([self checkLogin]) {
        return;
    }else{
    if (![self checkAcountMsg]) {
        [self.view endEditing:YES];
        return;
    }
    WS(weakSelf);
    NSDictionary *parasmeter = @{@"pwd":_phoneNumTF.text,
                                 @"newpwd":_passWordTF.text,
                                 @"confirmpwd":_inviteCodeTF.text
                                 };
    [WsHUD showHUDWithLabel:@"密码修改中..." modal:YES timeoutDuration:20.0];
    [SVCCommunityApi ResetPasswordWithNSDictionary:parasmeter type:@"editpwd" BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            [weakSelf.view toastShow:@"修改密码成功，请重新登录"];
            [SVCCurrUser changePassword:_inviteCodeTF.text];
            [SVCCurrUser deledateToken:@"1"];
            [SVCUserInfoUtil deleteFile];
           
            SVCLoginViewController *loginVC = [[SVCLoginViewController alloc] init];
            loginVC.type = @"1";
            SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:loginVC];
            [weakSelf.navigationController presentViewController:nav animated:YES completion:nil];
 [weakSelf.navigationController popViewControllerAnimated:NO];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
    }
}
- (BOOL)checkAcountMsg
{
    if ([_phoneNumTF.text length] < 6 || [_phoneNumTF.text length] > 15) {
         [self.view toastShow:@"旧密码输入有误"];
        return NO;
    }else if ([_passWordTF.text length] < 6 || [_passWordTF.text length] > 15){
         [self.view toastShow:@"新密码格式不对"];
        return NO;
    }else if ([_inviteCodeTF.text length] < 6 || [_inviteCodeTF.text length] > 15){
        [self.view toastShow:@"确认密码格式不对"];
        return NO;
    }else if (![_passWordTF.text isEqualToString:_inviteCodeTF.text]){
        [self.view toastShow:@"两次输入密码不一"];
        return NO;
    }else{
        return YES;
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
