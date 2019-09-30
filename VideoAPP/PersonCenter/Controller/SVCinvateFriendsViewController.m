///
//  SVCinvateFriendsViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCinvateFriendsViewController.h"
#import <CoreImage/CoreImage.h>
#import "QNTwoCodeTool.h"
#import "SVCInvitionModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface SVCinvateFriendsViewController ()
@property(nonatomic, strong) SVCInvitionModel *model; /**<<#属性#> */
@end

@implementation SVCinvateFriendsViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推广分享获取观影时间";
    if ([self.type isEqualToString:@"1"]) {
        [self checkLogin];
    }
    [self configBackGroundView];
    [self fetchData];
}

- (void)configBackGroundView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"diban"];
    imageView.userInteractionEnabled = YES;
    UIView *maskview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    maskview.backgroundColor = [UIColor blackColor];
    maskview.alpha = 0.2;
    [imageView addSubview:maskview];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
}

- (void)fetchData{
    WS(weakSelf);
    [weakSelf hudShowWithtitle:@"加载中..."];
    [SVCCommunityApi inviteFriendsDetailwithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf hudNil];
        if (code == 0) {
            self.model = [SVCInvitionModel mj_objectWithKeyValues:JSON];
            if (self.model.promotion_link.length) {
                [self setupSubviews];
            }else{
                [weakSelf.view toastShow:@"请在后台配置下载链接"];
            }
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [weakSelf hudNil];
        [weakSelf.view toastShow:netFailString];
    }];
}

- (void)setupSubviews{
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(GetWidthByScreenWidth(60), GetHeightByScreenHeigh(100), SCREEN_WIDTH - 2 * GetWidthByScreenWidth(60), GetHeightByScreenHeigh(340))];
    topview.backgroundColor = [UIColor whiteColor];
    topview.layer.cornerRadius = 4;
    topview.layer.masksToBounds = YES;
    [self.view addSubview:topview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = SVCColorFromRGB(0x333333);
    label.font = [UIFont systemFontOfSize:17];
    
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    //    CFShow(dicInfo);
    
    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
    
    
    NSString *textName = [NSString stringWithFormat:@"扫码下载%@APP",strAppName];
    label.text = textName;
    [label sizeToFit];
    label.centerX = topview.width * 0.5;
    label.y = 25;
    [topview addSubview:label];
    
    //    UIImage *image = [self createImgQRCodeWithString:@"www.baidu.com" centerImage:[UIImage imageNamed:@"logo.png"]];
    UIImage *image = [QNTwoCodeTool createNonInterpolatedUIImageFormCIImage:self.model.promotion_link withSize:160];
    UIImageView *qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 56, topview.width - 60, topview.width - 60)];
    qrImageView.image = image;
    qrImageView.contentMode = UIViewContentModeScaleToFill;
    [topview addSubview:qrImageView];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.textColor = SVCColorFromRGB(0x333333);
    codeLabel.font = [UIFont boldSystemFontOfSize:24];
    codeLabel.text = self.model.intive_code;
    [codeLabel sizeToFit];
    codeLabel.centerX = topview.width * 0.5;
    codeLabel.y = CGRectGetMaxY(qrImageView.frame) + 10;
    [topview addSubview:codeLabel];
    
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.textColor = SVCColorFromRGB(0x666666);
    desLabel.font = [UIFont systemFontOfSize:13];
    desLabel.text = @"您的推广码";
    [desLabel sizeToFit];
    desLabel.centerX = topview.width * 0.5;
    desLabel.y = CGRectGetMaxY(codeLabel.frame) + 5;
    [topview addSubview:desLabel];
    
    UILabel *saveLabel = [[UILabel alloc] init];
    saveLabel.textColor = SVCColorFromRGB(0xffffff);
    saveLabel.font = [UIFont systemFontOfSize:16];
    saveLabel.text = self.model.promotion_intro;
    saveLabel.textAlignment = NSTextAlignmentCenter;
    saveLabel.numberOfLines = 0;
    saveLabel.width = SCREEN_WIDTH - 30;
    saveLabel.X = 15;
    [saveLabel sizeToFit];
    saveLabel.centerX = SCREEN_WIDTH * 0.5;
    
    saveLabel.y = CGRectGetMaxY(topview.frame) + 15;
    [self.view addSubview:saveLabel];
    
    
    CGFloat margin = GetWidthByScreenWidth(24);
    
    UIButton *lelfButton = [self buttonWithTitle:@"保存二维码" titleColor:[UIColor whiteColor] backgroundColor:SVCMainColor action:@selector(leftButtonClick)];
    lelfButton.frame = CGRectMake(margin, CGRectGetMaxY(saveLabel.frame)+15, (SCREEN_WIDTH - 3 * margin) * 0.5, 45);
    
    UIButton *rightButton = [self buttonWithTitle:@"复制推广链接" titleColor:SVCMainColor backgroundColor:[UIColor whiteColor] action:@selector(rightButtonClick)];
    rightButton.frame = CGRectMake(margin * 2 + (SCREEN_WIDTH - 3 * margin) * 0.5, CGRectGetMaxY(saveLabel.frame)+15, (SCREEN_WIDTH - 3 * margin) * 0.5, 45);
    
    [self.view addSubview:lelfButton];
    [self.view addSubview:rightButton];
}

- (void)leftButtonClick{
    [self snipAndSaveImage];
}

//截屏并裁剪保存图片
- (void)snipAndSaveImage{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *snipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(snipImage,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        [self.view toastShow:@"保存成功"];
        
    }else{
        [self.view toastShow:@"保存失败"];
        
    }
    
}

- (void)rightButtonClick{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.model) {
        if (self.model.promotion_desc.length > 0) {
            NSString *string = self.model.promotion_desc;
            string = [string stringByReplacingOccurrencesOfString:@"{1}" withString:self.model.intive_code];
            pasteboard.string = string;
            [self.view toastShow:@"复制成功"];
        }else{
            [self.view toastShow:@"复制失败"];
        }
    }
}

- (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (BOOL)checkLogin
{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    BOOL ret = NO;
    if (token.length < 1) {
        SVCLoginViewController *logVC = [[SVCLoginViewController alloc] init];
        SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
        [self presentViewController:nav animated:YES completion:nil];
        ret = YES;
    }
    return ret;
}

- (void)getdatas
{
    WS(weakSelf);
    [weakSelf hudShowWithtitle:@"加载中..."];
    [SVCCommunityApi inviteFriendswithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf hudNil];
        if (code == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *lab = [weakSelf.view viewWithTag:1206];
                lab.text = JSON[@"intive_code"];
                UILabel *inviteLab = [weakSelf.view viewWithTag:1207];
                inviteLab.text = JSON[@"ios_download_url"];
            });
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [weakSelf hudNil];
        [weakSelf.view toastShow:netFailString];
    }];
}
- (void)getUrl{
    
    UILabel *inviteLab = [self.view viewWithTag:1207];
    UILabel *lab = [self.view viewWithTag:1206];
    if (inviteLab.text.length > 2) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [self.view toastShow:@"链接已粘贴"];
        pasteboard.string = [NSString stringWithFormat:@"%@\n邀请码：%@ \n下载地址：%@",AppName,lab.text,inviteLab.text];
    }
    
}
- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage{
    
    // 创建滤镜对象
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    
    [filter setDefaults];
    
    // 将字符串转换成 NSdata
    
    NSData *dataString = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    
    [filter setValue:dataString forKey:@"inputMessage"];
    
    // 获得滤镜输出的图像
    
    CIImage *outImage = [filter outputImage];
    
    // 图片小于(27,27),我们需要放大
    
    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    // 将CIImage类型转成UIImage类型
    
    UIImage *startImage = [UIImage imageWithCIImage:outImage];
    
    // 开启绘图, 获取图形上下文
    
    UIGraphicsBeginImageContext(startImage.size);
    
    
    
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    
    // 再把小图片画上去
    
    CGFloat icon_imageW = 40;
    
    CGFloat icon_imageH = icon_imageW;
    
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    
    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    
    // 获取当前画得的这张图片
    
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    
    UIGraphicsEndImageContext();
    
    //返回二维码图像
    
    return qrImage;
    
}

@end
