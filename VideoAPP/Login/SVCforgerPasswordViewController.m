//
//  SVCforgerPasswordViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/8.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCforgerPasswordViewController.h"
//#import "SVCNavigationController.h"
#import "SVCunderLineTF.h"
//#import "SVCLoginViewController.h"
#import "ToolClass.h"
#import <UIButton+WebCache.h>
#import "LXF_OpenUDID.h"
#import <SDWebImageDownloader.h>
@interface SVCforgerPasswordViewController ()<UITextFieldDelegate>
{
    SVCunderLineTF *_phoneNumTF;
    SVCunderLineTF *_passWordTF;
    SVCunderLineTF *_inviteCodeTF;
    UIButton *_forgetPasswordBtn;
    dispatch_source_t _timer;//验证码倒计时定时器
    SVCunderLineTF *_imageCodeTF;
    UIButton *_getImageBtn;
}
@end

@implementation SVCforgerPasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找回密码";
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (NSString *) getImageUrlStr
{
    return [NSString stringWithFormat:@"%@mobile/Verify/index/d_id/%@/%@",BASE_API,[LXF_OpenUDID value], [self currentdateInterval]];
}

#pragma mark --> 初始化UI
#pragma mark --> 初始化UI
- (void)setupUI{
    
    _phoneNumTF = [[SVCunderLineTF alloc] init];
    _phoneNumTF.frame = CGRectMake(20, GetHeightByScreenHeigh(60 + 44), kScreenWidth - 40, 40);
    NSDictionary *attr = @{NSForegroundColorAttributeName:SVCColorFromRGB(0xcccccc)};
    _phoneNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入注册手机号"attributes:attr];
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneNumTF];
    
    
    
    _imageCodeTF = [[SVCunderLineTF alloc] init];
    _imageCodeTF.frame = CGRectMake(20, CGRectGetMaxY(_phoneNumTF.frame)+20, kScreenWidth - 40 - 60, 40);
    _imageCodeTF.placeholder = @"请输入图片验证码";
    _imageCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入图片验证码" attributes:attr];
    [self.view addSubview:_imageCodeTF];
    
    UIView *LineView1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageCodeTF.frame), CGRectGetMaxY(_imageCodeTF.frame) - 1, 60, 1)];
    LineView1.backgroundColor = [UIColor hexStringToColor:@"b7b7b7"];
    [self.view addSubview:LineView1];
    
    _getImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getImageBtn.backgroundColor = BtnbgColor;
    [_getImageBtn setTitleColor:[UIColor whiteColor] forState:0];
    _getImageBtn.layer.cornerRadius = 3.0;
    _getImageBtn.clipsToBounds = YES;
    [_getImageBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    [_getImageBtn sd_setImageWithURL:[NSURL URLWithString: [self getImageUrlStr]] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
    _getImageBtn.frame = CGRectMake(kScreenWidth - 140, CGRectGetMinY(_imageCodeTF.frame)-5, 120, 40);
    [self.view addSubview:_getImageBtn];
    
    
    _passWordTF = [[SVCunderLineTF alloc] init];
    _passWordTF.frame = CGRectMake(20, CGRectGetMaxY(_imageCodeTF.frame)+20, kScreenWidth - 40 - 60, 40);
    
    _passWordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码"attributes:attr];
    
    _passWordTF.returnKeyType = UIReturnKeyDone;
    _passWordTF.delegate = self;
    [self.view addSubview:_passWordTF];
    
    _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetPasswordBtn.backgroundColor = BtnbgColor;
    [_forgetPasswordBtn setTitleColor:[UIColor whiteColor] forState:0];
    _forgetPasswordBtn.layer.cornerRadius = 3.0;
    _forgetPasswordBtn.clipsToBounds = YES;
    [_forgetPasswordBtn addTarget:self action:@selector(forgetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [_forgetPasswordBtn setTitle:@"验证码" forState:0];
    _forgetPasswordBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _forgetPasswordBtn.titleLabel.font = kFont(12);
    _forgetPasswordBtn.frame = CGRectMake(kScreenWidth - 75, CGRectGetMinY(_passWordTF.frame)+5, 55, 30);
    [self.view addSubview:_forgetPasswordBtn];
    
    
    UIView *LineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_passWordTF.frame), CGRectGetMaxY(_passWordTF.frame) - 1, 60, 1)];
    LineView.backgroundColor =SVCColorFromRGB(0xb7b7b7);
    [self.view addSubview:LineView];
    _inviteCodeTF = [[SVCunderLineTF alloc] init];
    _inviteCodeTF.frame = CGRectMake(20, CGRectGetMaxY(_passWordTF.frame)+20, kScreenWidth - 40, 40);
    _inviteCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入新密码"attributes:attr];
    
    _inviteCodeTF.returnKeyType = UIReturnKeyDone;
    _inviteCodeTF.secureTextEntry = YES;
    _inviteCodeTF.delegate = self;
    [self.view addSubview:_inviteCodeTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = BtnbgColor;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitle:@"完 成" forState:0];
    button.frame = CGRectMake(20, CGRectGetMaxY(_inviteCodeTF.frame)+88, kScreenWidth - 40, 45);
    button.layer.cornerRadius = 6.0;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)changeImage{
    [_getImageBtn sd_setImageWithURL:[NSURL URLWithString: [self getImageUrlStr]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图"] options:SDWebImageRefreshCached];
}
- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)forgetPasswordClick
{
    if (![self checkphoneNumber]) {
        return;
    }
    WS(weakSelf);
    NSDictionary *parasmeter = @{@"mobile":_phoneNumTF.text,
                                 @"event":@"resetpwd",
                                 @"verify_code":_imageCodeTF.text,
                                 @"d_id":[LXF_OpenUDID value]
                                 };
    [WsHUD showHUDWithLabel:@"验证码发送中..." modal:YES timeoutDuration:20.0];
    [SVCCommunityApi GetAuthCodeWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        [weakSelf countDown:60];
        _forgetPasswordBtn.userInteractionEnabled = NO;
        if (code == 0) {
            [weakSelf.view toastShow:@"验证码发送成功"];
        }else{
            [weakSelf.view toastShow:msg];
//            _forgetPasswordBtn.userInteractionEnabled = YES;
//            [weakSelf stopTimer];
//            [_forgetPasswordBtn setTitle:@"验证码" forState:0];
        }
    } andfail:^(NSError *error) {
        [weakSelf stopTimer];
        _forgetPasswordBtn.userInteractionEnabled = YES;
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}
- (void)btnClick:(UIButton *)sender
{
      WS(weakSelf);
    if (![self checkRegisterAccount]) {
        [self.view endEditing:YES];
        return;
    }
    [WsHUD showHUDWithLabel:@"密码重置中..." modal:YES timeoutDuration:20.0];
   
    NSDictionary *parasmeter = @{@"username":_phoneNumTF.text,
                                 @"code":_passWordTF.text,
                                 @"password":_inviteCodeTF.text
                                 };
    [SVCCommunityApi ResetPasswordWithNSDictionary:parasmeter type:@"resetpwd" BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
         [weakSelf stopTimer];
        if (code == 0) {
            [SVCCurrUser changePassword:_inviteCodeTF.text];
            [weakSelf.view toastShow:@"重置密码成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
          [weakSelf.view toastShow:netFailString];
    }];
    
}
#pragma mark -->检查输入是否正确
- (BOOL)checkRegisterAccount
{
    if (![self checkphoneNumber]) {
        [self.view endEditing:YES];
        return NO;
    }else if ([_passWordTF.text isEqualToString:@""]) {
         [self.view endEditing:YES];
        [self.view toastShow:@"请填写密码"];
        return NO;
    }else if ([_inviteCodeTF.text length] < 6 || [_inviteCodeTF.text length] > 15) {
         [self.view endEditing:YES];
        [self.view toastShow:@"密码必须是6-15位字符"];
        return NO;
    }else if (_passWordTF.text.length < 2){
         [self.view endEditing:YES];
        [self.view toastShow:@"请输入正确验证码"];
        return NO;
    }else{
         [self.view endEditing:YES];
        return YES;
    }
}
#pragma mark --> 检测手机号码
- (BOOL)checkphoneNumber
{
    if ([_phoneNumTF.text isEqualToString:@""]) {
        [self.view toastShow:@"请填写手机号码"];
        return NO;
    }else if (![ToolClass  isMobileNumber:_phoneNumTF.text]) {
        [self.view toastShow:@"手机号码错误，请重新输入"];
        return NO;
    }else if ([_phoneNumTF.text length] < 11 ||[_phoneNumTF.text length] > 11  ) {
        [self.view toastShow:@"请核对手机号码"];
        return NO;
    }else{
        return YES;
    }
}
#pragma mark --> 开启定时器
- (void)countDown:(NSInteger)mytime
{
    __block int timeout = (int) mytime; //倒计时时间
    WS(weakSelf);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf stopTimer];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_forgetPasswordBtn setTitle:@"验证码" forState:0];
                    _forgetPasswordBtn.userInteractionEnabled = YES;
                });
                
            });
        }else{
            //回到主界面
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_forgetPasswordBtn setTitle:[NSString stringWithFormat:@"%d s",timeout] forState:0];
            });
        }
    });
    
    dispatch_resume(_timer);
}
-(void)stopTimer{
    [_forgetPasswordBtn setTitle:@"验证码" forState:0];
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (NSString *)currentdateInterval
{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
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
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer];
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
