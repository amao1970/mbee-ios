//
//  SVCregistViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/8.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCregistViewController.h"
#import "SVCunderLineTF.h"
#import "ToolClass.h"
#import <UIButton+WebCache.h>
#import "LXF_OpenUDID.h"
#import <SDWebImageDownloader.h>
@interface SVCregistViewController ()<UITextFieldDelegate>
{
    SVCunderLineTF *_phoneNumTF;
    SVCunderLineTF *_passWordTF;
    SVCunderLineTF *_imageCodeTF;
    SVCunderLineTF *_codeTF;
    SVCunderLineTF *_inviteCodeTF;
    UIButton *_getSMSBtn;
    UIButton *_getImageBtn;
    dispatch_source_t _timer;//验证码倒计时定时器
}
@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) NSInteger countdownTimer;
@end

@implementation SVCregistViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSmsMopenData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self setupUI];
    // Do any additional setup after loading the view.
    [self observeApplicationActionNotification];
}

- (NSString *) getImageUrlStr
{
    return [NSString stringWithFormat:@"%@mobile/Verify/index/d_id/%@/%@",BASE_API,[LXF_OpenUDID value], [self currentdateInterval]];
}

-(void)getSmsMopenData
{
    WS(weakSelf);
    [self hudShowWithtitle:@"正在加载中..."];
    [SVCCommunityApi GetSmsMopenWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf hudNil];
        if (code == 0) {
            if ([JSON[@"value"] integerValue] == 0) {
                _codeTF.hidden = _getSMSBtn.hidden = YES;
                _passWordTF.y = CGRectGetMaxY(_imageCodeTF.frame)+20;
                _inviteCodeTF.y = CGRectGetMaxY(_passWordTF.frame)+20;
                _codeTF.userInteractionEnabled = NO;
            }else{
                
            }
            
            if ([JSON[@"showinvita"] integerValue] == 0) {
                _inviteCodeTF.hidden = YES;
                _inviteCodeTF.userInteractionEnabled = NO;
            }
        }else {
            
        }
        
    } andfail:^(NSError *error) {
        
    }];
}
#pragma mark --> 初始化UI
- (void)setupUI
{
    
    NSDictionary *attr = @{NSForegroundColorAttributeName:SVCColorFromRGB(0xbbbbbb)};
    
    _phoneNumTF = [[SVCunderLineTF alloc] init];
    _phoneNumTF.frame = CGRectMake(20, 60, kScreenWidth - 40, 40);
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入真实手机号（否则无法找回）" attributes:attr];
    [self.view addSubview:_phoneNumTF];
    
    _imageCodeTF = [[SVCunderLineTF alloc] init];
    _imageCodeTF.frame = CGRectMake(20, CGRectGetMaxY(_phoneNumTF.frame)+20, kScreenWidth - 40 - 60, 40);
    _imageCodeTF.placeholder = @"请输入图片验证码";
    _imageCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入图片验证码" attributes:attr];
    [self.view addSubview:_imageCodeTF];
    
    UIView *LineView1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageCodeTF.frame), CGRectGetMaxY(_imageCodeTF.frame) - 1, 60, 1)];
    LineView1.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.view addSubview:LineView1];
    
    _getImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getImageBtn.backgroundColor = BtnbgColor;
    [_getImageBtn setTitleColor:[UIColor whiteColor] forState:0];
    _getImageBtn.layer.cornerRadius = 3.0;
    _getImageBtn.clipsToBounds = YES;
    [_getImageBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    [_getImageBtn sd_setImageWithURL:[NSURL URLWithString: [self getImageUrlStr]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图"] options:SDWebImageRefreshCached];
    _getImageBtn.frame = CGRectMake(kScreenWidth - 140, CGRectGetMinY(_imageCodeTF.frame)-5, 120, 40);
    [self.view addSubview:_getImageBtn];
    
    _codeTF = [[SVCunderLineTF alloc] init];
    _codeTF.frame = CGRectMake(20, CGRectGetMaxY(_imageCodeTF.frame)+20, kScreenWidth - 40 - 60, 40);
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:attr];
    [self.view addSubview:_codeTF];
    
    _getSMSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getSMSBtn.backgroundColor = BtnbgColor;
    [_getSMSBtn setTitleColor:[UIColor whiteColor] forState:0];
    _getSMSBtn.layer.cornerRadius = 3.0;
    _getSMSBtn.clipsToBounds = YES;
    [_getSMSBtn addTarget:self action:@selector(getSMS) forControlEvents:UIControlEventTouchUpInside];
    [_getSMSBtn setTitle:@"验证码" forState:0];
    _getSMSBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _getSMSBtn.titleLabel.font = kFont(12);
    _getSMSBtn.frame = CGRectMake(kScreenWidth - 75, CGRectGetMinY(_codeTF.frame)+5, 55, 30);
    [self.view addSubview:_getSMSBtn];
    UIView *LineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_codeTF.frame), CGRectGetMaxY(_codeTF.frame) - 1, 60, 1)];
    LineView.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.view addSubview:LineView];
    
    _passWordTF = [[SVCunderLineTF alloc] init];
    _passWordTF.frame = CGRectMake(20, CGRectGetMaxY(_codeTF.frame)+20, kScreenWidth - 40, 40);
    _passWordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的密码" attributes:attr];
    _passWordTF.returnKeyType = UIReturnKeyDone;
    _passWordTF.secureTextEntry = YES;
    _passWordTF.delegate = self;
    [self.view addSubview:_passWordTF];
    
    _inviteCodeTF = [[SVCunderLineTF alloc] init];
    _inviteCodeTF.frame = CGRectMake(20, CGRectGetMaxY(_passWordTF.frame)+20, kScreenWidth - 40, 40);
    _inviteCodeTF.returnKeyType = UIReturnKeyDone;
    _inviteCodeTF.delegate = self;
    _inviteCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:attr];
    [self.view addSubview:_inviteCodeTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = BtnbgColor;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitle:@"注 册" forState:0];
    button.frame = CGRectMake(20, CGRectGetMaxY(_inviteCodeTF.frame) + 20, kScreenWidth - 40, 45);
    button.layer.cornerRadius = 6.0;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}


- (void)changeImage
{
    [_getImageBtn sd_setImageWithURL:[NSURL URLWithString: [self getImageUrlStr]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图"] options:SDWebImageRefreshCached];
}

#pragma mark --> 开启定时器
- (void)countDown:(NSInteger)mytime
{
    __block int timeout = (int) mytime; //倒计时时间
    _countdownTimer = mytime;
    WS(weakSelf);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(_countdownTimer <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf stopTimer];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_getSMSBtn setTitle:@"验证码" forState:0];
                    _getSMSBtn.userInteractionEnabled = YES;
                });
                
            });
        }else{
            //回到主界面
            _countdownTimer --;
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_getSMSBtn setTitle:[NSString stringWithFormat:@"%lds",_countdownTimer] forState:0];
                
            });
        }
    });
    
    dispatch_resume(_timer);
}

#pragma mark --> 获取验证码
- (void)getSMS
{
    if (![self checkphoneNumber]) {
        return;
    }
    if (_imageCodeTF.text.length <= 0) {
        [self.view toastShow:@"图片验证码不能为空"];
        return;
    }
    WS(weakSelf);
    NSDictionary *parasmeter = @{
                                 @"d_id":[LXF_OpenUDID value],
                                 @"mobile":_phoneNumTF.text,
                                 @"event":@"register",
                                 @"verify_code":_imageCodeTF.text
                                 };
    [weakSelf hudShowWithtitle:@"验证码发送中..."];
    [SVCCommunityApi GetAuthCodeWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf hudNil];
        if (code == 0) {
            [weakSelf countDown:60];
            _getSMSBtn.userInteractionEnabled = NO;
            [weakSelf.view toastShow:@"验证码发送成功"];
        }else {
            [weakSelf.view toastShow:msg];
        }
        
    } andfail:^(NSError *error) {
        [weakSelf hudNil];
        [weakSelf stopTimer];
        _getSMSBtn.userInteractionEnabled = YES;
        [_getSMSBtn setTitle:@"验证码" forState:0];
        [weakSelf.view toastShow:netFailString];
    }];
}

#pragma mark --> 注册
- (void)btnClick:(UIButton *)sender
{
    WS(weakSelf);
    if (![weakSelf checkRegisterAccount]) {
        return;
    }
    NSDictionary *parasmeter = @{@"username":_phoneNumTF.text,
                                 @"password":_passWordTF.text,
                                 @"referrer":_inviteCodeTF.isHidden ? @"" : _inviteCodeTF.text,
                                 @"code":_codeTF.text.length ? _codeTF.text : @"",
                                 @"d_id":[LXF_OpenUDID value]
                                 };
    [weakSelf hudShowWithtitle:@"正在注册..."];
    [SVCCommunityApi RegUserWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf hudNil];
        if (code == 0) {
            [SVCCurrUser SaveLoginInfoToken:JSON[@"token"] andPhoneNumber:_phoneNumTF.text andUserID:JSON[@"uid"] andPassword:_passWordTF.text andLoginType:@"login"];
            SVCCurrUser *useInfo = [SVCCurrUser mj_objectWithKeyValues:JSON];
            [weakSelf stopTimer];
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            [ud setValue:JSON[@"token"] forKey:@"token"];
            [ud setValue:JSON[@"uid"] forKey:@"uid"];
            [ud synchronize];
            [SVCUserInfoUtil mSaveUser:useInfo];
            [weakSelf.view toastShow:@"注册成功"];
            [weakSelf autionLogin];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [weakSelf hudNil];
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
    }else if ([_passWordTF.text length] < 6 || [_passWordTF.text length] > 15) {
        [self.view endEditing:YES];
        [self.view toastShow:@"密码必须是6-15位字符"];
        return NO;
    }else if (_codeTF.text.length < 2 && _codeTF.userInteractionEnabled){
        [self.view endEditing:YES];
        [self.view toastShow:@"请输入正确验证码"];
        return NO;
    }else if (_inviteCodeTF.text.length < 1 && _inviteCodeTF.isHidden == NO){
        [self.view endEditing:YES];
        [self.view toastShow:@"请输入正确邀请码"];
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
- (void)autionLogin
{
    WS(weakSelf);
    NSDictionary *parasmeter = @{@"username":_phoneNumTF.text,
                                 @"password":_passWordTF.text};
    [SVCCommunityApi LoginWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [SVCCurrUser SaveLoginInfoToken:JSON[@"token"] andPhoneNumber:_phoneNumTF.text andUserID:JSON[@"uid"] andPassword:_passWordTF.text andLoginType:@"login"];
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [weakSelf.view toastShow:@"请返回登录"];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:@"请返回登录"];
    }];
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
-(void)stopTimer{
    [_getSMSBtn setTitle:@"验证码" forState:0];
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
#pragma mark --> 返回
- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)observeApplicationActionNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationDidEnterBackground {
    _timestamp = [NSDate date].timeIntervalSince1970;
}

- (void)applicationDidBecomeActive {
    
    NSTimeInterval timeInterval = [NSDate date].timeIntervalSince1970-_timestamp;
    _timestamp = 0;
    
    NSTimeInterval ret = _countdownTimer - timeInterval;
    if (ret>0) {
        _countdownTimer = ret;
        
    } else {
        _countdownTimer = 0;
    }
    
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
