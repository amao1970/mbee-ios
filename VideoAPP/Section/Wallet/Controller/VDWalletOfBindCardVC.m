//
//  VDWalletOfBindCardVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDWalletOfBindCardVC.h"

#import "VDWalletOfBindCardView.h"
#import <Photos/Photos.h>

#import <SDWebImage/UIButton+WebCache.h>

@interface VDWalletOfBindCardVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) VDWalletOfBindCardView *mainView;
@property (nonatomic, strong) NSDictionary * payInfoDic;
@property (nonatomic, strong) UIImage *aliPayQRimg;
@property (nonatomic, strong) UIImage *wxPayQRimg;
@property (nonatomic, strong) NSString *aliPayName;
@property (nonatomic, strong) NSString *wxPayName;
@property (nonatomic, assign) BOOL isAlipayDefault;

@end

@implementation VDWalletOfBindCardVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"提现账户设置";
    [self setUpMainView];
    [self getPayAccount];
}

-(void)setUpMainView{
    self.mainView = [VDWalletOfBindCardView getViewFormNSBunld];
    self.mainView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    self.mainView.alipayBtn.selected = YES;
    [self setUpPay];
    [self.mainView.commit addTarget:self action:@selector(click_commit) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.alipayBtn addTarget:self action:@selector(click_aliPay) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.wechatPay addTarget:self action:@selector(click_wechatPay) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.qrImgBtn addTarget:self action:@selector(click_qrImgBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.defaultView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_selectView)]];
    [self.mainView.nameLab addTarget:self action:@selector(editNameTF:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.mainView];
}

-(void)editNameTF:(UITextField*)tf{
    if (self.mainView.alipayBtn.isSelected == YES) {
        self.aliPayName = tf.text;
    }else{
        self.wxPayName = tf.text;
    }
}

-(void)click_aliPay{
    self.mainView.alipayBtn.selected = YES;
    self.mainView.wechatPay.selected = NO;
    [self setUpPay];
}

-(void)click_wechatPay{
    self.mainView.alipayBtn.selected = NO;
    self.mainView.wechatPay.selected = YES;
    [self setUpPay];
}

-(void)click_selectView{
    self.mainView.selectBtn.selected = !self.mainView.selectBtn.isSelected;
    if (self.mainView.alipayBtn.isSelected == YES) {
        self.isAlipayDefault = self.mainView.selectBtn.isSelected;
    }else{
        self.isAlipayDefault = !self.mainView.selectBtn.isSelected;
    }
}

-(void)getPayAccount{
    [WsHUD showHUDWithLabel:@"正在获取..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking get:@"/mobile/user/apply" parameters:nil finished:^(JXRequestModel *obj) {
        NSLog(@"%@",obj);
        self.payInfoDic = [obj getResultDictionary][@"list"];
        NSDictionary *alipayDIC = self.payInfoDic[@"alipay"];
        NSDictionary *wxpayDIC = self.payInfoDic[@"wxpay"];
        
        
        if([wxpayDIC[@"uname"] length]){
            self.mainView.wechatPay.selected = YES;
            self.wxPayName = [NSString stringWithFormat:@"%@",wxpayDIC[@"uname"]];
            NSURL * url = [NSURL URLWithString:wxpayDIC[@"img"]];
            // 根据图片的url下载图片数据
            dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
            dispatch_async(xrQueue, ^{
                // 异步下载图片
                UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                // 主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.wxPayQRimg = img;
                });
            });
            self.isAlipayDefault = ![wxpayDIC[@"isdefal"] boolValue];
        }
        if ([alipayDIC[@"uname"] length]) {
            self.mainView.alipayBtn.selected = YES;
            self.mainView.wechatPay.selected = NO;
            self.aliPayName = [NSString stringWithFormat:@"%@",alipayDIC[@"uname"]];
            NSURL * url = [NSURL URLWithString:alipayDIC[@"img"]];
            // 根据图片的url下载图片数据
            dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
            dispatch_async(xrQueue, ^{
                // 异步下载图片
                UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                // 主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.aliPayQRimg = img;
                });
            });
            self.isAlipayDefault = [alipayDIC[@"isdefal"] boolValue];
        }
        
        
        [self setUpPay];
        [WsHUD hideHUD];
    } failed:^(JXRequestModel *obj) {
        [[UIApplication sharedApplication].keyWindow.rootViewController.view hideToasts];
        [WsHUD hideHUD];
    }];
}

-(void)setUpPay{
    if (self.mainView.alipayBtn.isSelected) {
        self.mainView.alipayBtn.layer.borderWidth = 1;
        self.mainView.alipayBtn.layer.borderColor = [UIColor hexStringToColor:@"ef8438"].CGColor;
        self.mainView.wechatPay.layer.borderWidth = 0;
        self.mainView.wechatPay.layer.borderColor = [UIColor hexStringToColor:@"ef8438"].CGColor;
        self.mainView.wechatPay.selected = NO;
        self.mainView.selectBtn.selected = self.isAlipayDefault;
        self.mainView.nameLab.text = self.aliPayName;
        if (self.aliPayQRimg) {
            [self.mainView.qrImgBtn setImage:self.aliPayQRimg forState:UIControlStateNormal];
        }else{
            NSURL * url = [NSURL URLWithString:self.payInfoDic[@"alipay"][@"img"]];
            [self.mainView.qrImgBtn sd_setImageWithURL:url forState:UIControlStateNormal];
        }
    }else{
        self.mainView.alipayBtn.layer.borderWidth = 0;
        self.mainView.alipayBtn.layer.borderColor = [UIColor hexStringToColor:@"ef8438"].CGColor;
        self.mainView.wechatPay.layer.borderWidth = 1;
        self.mainView.wechatPay.layer.borderColor = [UIColor hexStringToColor:@"ef8438"].CGColor;
        self.mainView.alipayBtn.selected = NO;
        self.mainView.selectBtn.selected = !self.isAlipayDefault;
        self.mainView.nameLab.text = self.wxPayName;
        if (self.aliPayQRimg) {
            [self.mainView.qrImgBtn setImage:self.wxPayQRimg forState:UIControlStateNormal];
        }else{
            NSURL * url = [NSURL URLWithString:self.payInfoDic[@"wxpay"][@"img"]];
            [self.mainView.qrImgBtn sd_setImageWithURL:url forState:UIControlStateNormal];
        }
    }
}

-(void)click_qrImgBtn{
    // iOS 8.0以上系统
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    NSLog(@"openGallery_authorStatus == %ld",(long)authorStatus);
    if (authorStatus == PHAuthorizationStatusAuthorized ||
        authorStatus == PHAuthorizationStatusNotDetermined){
        //获取权限
        //        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"相机权限不足，设置相机权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
                
            }
        }];
        [alertController addAction:okAction];
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:closeAction];
        [self presentViewController:alertController animated:YES completion:nil];
        ;
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.navigationBar.tintColor = [UIColor blackColor];
    [self.tabBarController presentViewController:picker animated:YES completion:^{
        UIViewController*vc = picker.viewControllers.lastObject;
        picker.navigationBar.tintColor = [UIColor blackColor];
        vc.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }];
}

#pragma mark --UIImagePickerControllerDelegate
// 当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        if (self.mainView.alipayBtn.isSelected) {
            self.aliPayQRimg = img;
        }else{
            self.wxPayQRimg = img;
        }
//        self.mainView.qrImgBtn.imageView.image = img;
        [self.mainView.qrImgBtn setImage:img forState:UIControlStateNormal];
//        [self updateImg:img];
    }
}

-(void)click_commit{
    NSMutableDictionary *alipayDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *wxpayDic = [NSMutableDictionary dictionary];
    
    if (self.aliPayQRimg || self.aliPayName.length) {
        if (self.aliPayName.length <= 0) {
            [self.view hideToasts];
            [self.view makeToast:@"请输入支付宝收款人" duration:4.5 position:CSToastPositionCenter];
            return;
        }else if (!self.aliPayQRimg){
            [self.view hideToasts];
            [self.view makeToast:@"请上传支付宝二维码" duration:4.5 position:CSToastPositionCenter];
            return;
        }
        alipayDic = @{@"uname":self.aliPayName,
                      @"img":[@"data:image/jpeg;base64," stringByAppendingFormat:@"%@",[self imageToString:self.aliPayQRimg]],
                      @"isdefault":@(self.isAlipayDefault),
                      }.mutableCopy;
    }else{
        self.isAlipayDefault = NO;
    }
    
    if (self.wxPayQRimg || self.wxPayName.length) {
        if (self.wxPayName.length <= 0) {
            [self.view hideToasts];
            [self.view makeToast:@"请输入微信收款人" duration:4.5 position:CSToastPositionCenter];
            return;
        }else if (!self.wxPayQRimg){
            [self.view hideToasts];
            [self.view makeToast:@"请上传微信二维码" duration:4.5 position:CSToastPositionCenter];
            return;
        }
        wxpayDic = @{@"uname":self.wxPayName,
                     @"img":[@"data:image/jpeg;base64," stringByAppendingFormat:@"%@",[self imageToString:self.wxPayQRimg]],
                     @"isdefault":@(!self.isAlipayDefault),
                     }.mutableCopy;
    }else{
        if (alipayDic.allKeys.count == 0 && wxpayDic.allKeys.count == 0) {
            [self.view hideToasts];
            [self.view makeToast:@"请输入收款人信息" duration:4.5 position:CSToastPositionCenter];
            return;
        }
        
        self.isAlipayDefault = YES;
        [alipayDic setValue:@(self.isAlipayDefault) forKey:@"isdefault"];
    }
    
    
    NSDictionary *info = @{
                           @"alipay":alipayDic,
                           @"wxpay":wxpayDic
                           };
    [WsHUD showHUDWithLabel:@"正在提交..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking method:@"/mobile/user/accountset" parameters:info finished:^(JXRequestModel *obj) {
        [self.view toastShow:@"设置成功"];
        [WsHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];

}

// 图片转64base字符串
- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImageJPEGRepresentation(image, 0.2) ;//UIImagePNGRepresentation(image);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}
@end
