//
//  XMLiveViewController.m
//  SmartValleyCloudSeeding
//
//  Created by on 2018/6/14.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "XMLiveViewController.h"
#import <PLPlayerKit/PLPlayerKit.h>
#import "UIView+XMframe.h"
#import "BKNetworkHelper.h"
#import "SVCLiveModel.h"
#import "SVCLoadingView.h"
//#import "SVCLoadManager.h"
#import "SVCPlayerWebViewController.h"
#import "SVCLiveToolBtn.h"
#import "SVCRechargeVC.h"
#import "LiveGiftShowCustom.h"

#import "SVProgressHUD.h"

#define Url @"http://www.w3school.com.cn/i/movie.mp4"
#define video_url @"http://edge.ivideo.sina.com.cn/6376446.flv?KID=sina,viask&Expires=1529078400&ssig=8F7%2FQP5Ra8"
#define url_mp4 @"http://download.3g.joy.cn/video/236/60236853/1450837945724_hd.mp4"

@interface XMLiveViewController ()<PLPlayerDelegate,LiveGiftShowCustomDelegate>
{
//    UILabel *_systemLabel;
}
@property (nonatomic, strong) NSMutableArray<UILabel*> *lableAry;
@property (nonatomic,strong) PLPlayer *player;

@property (nonatomic,strong) UIButton *jubaoBut;

@property (nonatomic,strong) UIButton *guanbiBut;

@property (nonatomic,strong) UILabel *systemLa;

@property (nonatomic ,weak) LiveGiftShowCustom * customGiftShow;
@property (nonatomic, strong) LiveGiftListModel * giftModel;
@property (nonatomic, strong) LiveUserModel *fifthUser;

@end

@implementation XMLiveViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor blackColor];
    [self.player play];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.player stop];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lableAry = [NSMutableArray array];
    self.giftModel = [LiveGiftListModel mj_objectWithKeyValues:@{
                                                                 @"name": @"泡泡糖",
                                                                 @"rewardMsg": @"送出一个赞",
                                                                 @"personSort": @"2",
                                                                 @"goldCount": @"8",
                                                                 @"type": @"4",
                                                                 @"picUrl": @"good"
                                                                 }];
    
    self.view.backgroundColor = [UIColor blackColor];
//    SVCLoadingView *loadingView = [[SVCLoadingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    self.loadView = loadingView;
//    [self.view addSubview:loadingView];
    
//    [manager showLoadIng];
//    [[UIApplication sharedApplication] addObserver:self forKeyPath:@"idleTimerDisabled" options:NSKeyValueObservingOptionNew context:nil];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self playVideo];
    [self setUI];
    [self setUpTool];
    [self createSignle];
    //初始化弹幕视图
    [self customGiftShow];
}

- (void)v15BtnClicked:(UIButton *)clickedBtn{
    LiveGiftShowModel * model = [LiveGiftShowModel giftModel:self.giftModel userModel:self.fifthUser];
    [self.customGiftShow animatedWithGiftModel:model];
}

-(void)createSignle{
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD showInfoWithStatus:@"加载中..."];
//    [WsHUD showHUDWithLabel:@"加载中..." modal:NO timeoutDuration:20.0];
//    SVCLoadManager *manager = [SVCLoadManager shareManagare];
//    [manager showLoadIng];
}
- (CGFloat)getLabelHeightWithText:(NSString *)text height:(CGFloat)height font: (CGFloat)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(font)} context:nil];
    return rect.size.width;
}
- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 25)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

-(void)setUpTool{
    NSInteger collectionRand = arc4random() % 100;
    SVCLiveToolBtn *btn = [self creatToolBtn:CGRectMake(SCR_WIDTH - 60, SCR_HIGHT - Nav_HEIGHT - 200, 50, 55)
                                      btnImg:@"star_icon"
                                    btnTitle:[@""  stringByAppendingFormat:@"%.1f万",collectionRand/10.f]];
    [self.view addSubview:btn];
    
    NSInteger zanRand = arc4random() % 100;
    SVCLiveToolBtn *btn2 = [self creatToolBtn:CGRectMake(SCR_WIDTH - 60, SCR_HIGHT - Nav_HEIGHT - 140, 50, 55)
                                      btnImg:@"zan_icon"
                                    btnTitle:[@""  stringByAppendingFormat:@"%.1f万",zanRand/10.f]];
    [btn2 addTarget:self action:@selector(v15BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    NSInteger shareRand = arc4random() % 100;
    SVCLiveToolBtn *btn3 = [self creatToolBtn:CGRectMake(SCR_WIDTH - 60, SCR_HIGHT - Nav_HEIGHT - 80, 50, 55)
                                       btnImg:@"share_icon"
                                     btnTitle:[@""  stringByAppendingFormat:@"%.1f万",shareRand/10.f]];
    [btn3 addTarget:self action:@selector(click_share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    self.lableAry.lastObject.y = btn3.bottom - self.lableAry.lastObject.height - 5;;
}

-(void)click_share{
    SVCinvateFriendsViewController *targent = [[SVCinvateFriendsViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

-(SVCLiveToolBtn*)creatToolBtn:(CGRect)frame btnImg:(NSString *)imgName btnTitle:(NSString*)title{
    SVCLiveToolBtn *btn = [[SVCLiveToolBtn alloc] init];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

-(void)setUI{
    UIButton *buttonJuBao = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonJuBao setBackgroundImage:[UIImage imageNamed:@"jubao"] forState:UIControlStateNormal];
    buttonJuBao.frame = CGRectMake(15, kScreenHeight-69, 35, 35);
    [self.view addSubview:buttonJuBao];
    self.jubaoBut = buttonJuBao;
    buttonJuBao.tag = 1000;
    [buttonJuBao addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonXinxi = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonXinxi setBackgroundImage:[UIImage imageNamed:@"gongping"] forState:UIControlStateNormal];
    buttonXinxi.tag = 1001;
    buttonXinxi.hidden = YES;
    buttonXinxi.frame = CGRectMake(90, kScreenHeight-69, 35, 35);
    [self.view addSubview:buttonXinxi];
    [buttonXinxi addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonDanmu = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDanmu setBackgroundImage:[UIImage imageNamed:@"guandanmu_di"] forState:UIControlStateNormal];
    [buttonDanmu setTitle:@"关广告" forState:UIControlStateNormal];
    [buttonDanmu setTitle:@"开广告" forState:UIControlStateSelected];
    buttonDanmu.tag = 1002;
    buttonDanmu.frame = CGRectMake(150, kScreenHeight-69, 85, 35);
    buttonDanmu.centerX = self.view.centerX;
    [self.view addSubview:buttonDanmu];
    [buttonDanmu addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonguanbi = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonguanbi setBackgroundImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    buttonguanbi.tag = 1003;
    buttonguanbi.frame = CGRectMake(kScreenWidth-50, kScreenHeight-69, 35, 35);
    self.guanbiBut = buttonguanbi;
    [self.view addSubview:buttonguanbi];
    [buttonguanbi addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = [self calculateRowWidth:self.liveModle.title];
    
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 35, width + 20 + 40 , 40)];
    UIColor *color = [UIColor hexStringToColor:@"#000000"];
    color = [color colorWithAlphaComponent:0.3];
    topView.backgroundColor = color;
    topView.layer.cornerRadius = 20.f;
    topView.layer.masksToBounds = YES;
    [self.view addSubview:topView];
    
    UIImageView *leftImageview = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 36, 36)];
//    leftImageview.backgroundColor = [UIColor whiteColor];
    [leftImageview sd_setImageWithURL:[NSURL URLWithString:self.liveModle.img] placeholderImage:[UIImage imageNamed:@"默认图"]];
    leftImageview.layer.cornerRadius = 18.f;
    leftImageview.layer.masksToBounds = YES;
    [topView addSubview:leftImageview];
    
    
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(47, 7.5, width + 8, 25)];
        lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
        lab.text = self.liveModle.title;
        lab.font = kFont(13);
    
    if ((width+47+15+36) > SCR_WIDTH) {
        topView.width = SCR_WIDTH - 15;
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(40, 0, topView.width - 40, topView.height);
        view.layer.masksToBounds = YES;
        [topView addSubview:view];
        [view addSubview:lab];
        float time = (lab.width+SCR_WIDTH) / 100.f*2;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionRepeat  animations:^{
            lab.transform = CGAffineTransformMakeTranslation(-lab.width, 0);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [topView addSubview:lab];
    }

    NSString *title = _systemMessage[@"adtext"];
    if (!_systemMessage[@"adtext"] || !title.length ) {
        buttonDanmu.hidden = YES;
        return;
    }
    
        UILabel *label = [[UILabel alloc]init];
        //    systemLabel.backgroundColor = [UIColor whiteColor];
        label.X = 15;
        label.Y = kScreenHeight-260;
        label.width = (SCREEN_WIDTH - 55) * 0.9;
        label.height = 200;
        label.numberOfLines = 0;
        label.font = kFont(14);
        label.text = [NSString stringWithFormat:@"    %@",_systemMessage[@"adtext"]];
        label.textColor = [UIColor purpleColor];
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
        label.layer.cornerRadius = 8;
        label.layer.masksToBounds = YES;
        //    self.systemLa = systemLabel;
        [self.view addSubview:label];
        
        label.left = 10;
        
        //初始化富文本对象
        NSMutableAttributedString *attri= [[NSMutableAttributedString alloc]initWithString:label.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //    [paragraphStyle setLineSpacing:10];//调整行间距
        //    paragraphStyle.lineHeightMultiple = 30;
        paragraphStyle.maximumLineHeight = 30;
        paragraphStyle.minimumLineHeight = 29;
        
        //修改富文本中的不同文字的样式
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,label.text.length)];
        //    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(7,6)];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.height = 25;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor redColor];
        [btn setImage:[UIImage imageNamed:@"13071542871430"] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"  %@",_systemMessage[@"name"]] forState:UIControlStateNormal];
        btn.width = 60;
        btn.width = [btn.titleLabel sizeThatFits:btn.titleLabel.size].width + 30;
        btn.layer.cornerRadius = 4;
        
        //初始化NSTextAttachment对象
        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
        //设置frame
        attch.bounds = CGRectMake(5, -8, btn.width, 25);
        //设置图片
        attch.image = [self convertViewToImage:btn];
        // 创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attch)];
        //插入到第几个下标
        [attri insertAttributedString:string atIndex:2];
        [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
        // 用label的attributedText属性来使用富文本
        label.attributedText = attri;
        label.height = [label sizeThatFits:label.size].height + 20;
        
        label.y = buttonDanmu.y - label.height - 30;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_adv:)]];
        label.userInteractionEnabled = YES;
        [self.lableAry addObject:label];
}

-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)buttonCLick:(UIButton *)but{
    if (but.tag==1000) {
        NSLog(@"举报");
        SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
        WS(weakSelf);
        if (self.isReplay || ![user.is_agent isEqualToString:@"1"]) {
            [self.view toastShow:@"举报成功"];
            return;
        }
        
        [WsHUD showHUDWithLabel:@"举报中..." modal:YES timeoutDuration:20.0];
        NSString *title = self.liveModle.title ? self.liveModle.title : @"";
        NSString *address = self.liveAddressStr.length ? self.liveAddressStr : @"";
        [SVCCommunityApi UserReportWithNSDiction:@{@"nickname":[@"" stringByAppendingFormat:@"%@",address]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                [weakSelf.view toastShow:@"举报成功"];
            }else{
                [weakSelf.view toastShow:msg];
            }
            [WsHUD hideHUD];
        } andfail:^(NSError *error) {
            [WsHUD hideHUD];
        }];
        
    }else if(but.tag==1002){
        but.selected=!but.selected;
        if (but.selected) {
            [self.lableAry enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.hidden = YES;
            }];
        }else{
            [self.lableAry enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.hidden = NO;
            }];
        }
    }else if(but.tag==1003){
        [WsHUD hideHUD];
//        SVCLoadManager *manager = [SVCLoadManager shareManagare];
//        [manager HideLoadIng];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
}
-(void)playVideo{
    
    PLPlayerOption *xmoption = [PLPlayerOption defaultOption];
    [xmoption setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [xmoption setOptionValue:@"kPLPLAY_FORMAT_FLV" forKey:PLPlayerOptionKeyVideoPreferFormat];
    NSURL *url = [NSURL URLWithString:self.liveAddressStr];
    self.player = [PLPlayer playerWithURL:url option:xmoption];
    self.player.delegate = self;
//    self.player.launchView = [[UIImageView alloc] initWithImage:showImage(@"banner")];
//    self.player.launchView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    [self.player.launchView setHidden:NO];
    self.player.playerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    self.player.playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.player.playerView];
    [self.player play];
}

-(void)setNavRightButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 20);
    [button setTitle:@"举报" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBUttonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
-(void)rightBUttonClick{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"举报已受理，感谢您的反馈" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    
            }];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        SVCLoadManager *manager = [SVCLoadManager shareManagare];
//        [manager HideLoadIng];
        [SVProgressHUD dismiss];
    });
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"主播可能离开了" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state{
    NSLog(@"====%ld",state);
//        SVCLoadManager *manager = [SVCLoadManager shareManagare];

    if (state == 5) {
        [SVProgressHUD dismiss];
//             [manager HideLoadIng];

    }
}

/** 显示自定义的信息 */
-(void)showCustomMessageWithString:(NSString *)message{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor blackColor];
    showView.alpha = 1.0f;
    showView.width = 60;
    showView.height = 35;
    showView.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    showView.layer.cornerRadius = 5.0;
    showView.layer.masksToBounds = YES;
    //放在最上层
    [window insertSubview:showView atIndex:9999];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = showView.bounds;
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [showView addSubview:label];
    
    //使用动画
    [UIView animateWithDuration:2 animations:^{
        //透明度变0
        showView.alpha=0;
    } completion:^(BOOL finished) {
        //移除视图
        [showView removeFromSuperview];
    }];
}

-(void)getMessage{
//        BKNetworkHelper *hepl = [BKNetworkHelper shareInstance];
//        NSString *xmurl = [NSString stringWithFormat:@"%@mobile/index/checkUser",BASE_API];
//        [hepl POST:xmurl Parameters:nil Success:^(id responseObject) {
//            NSString *strMsg = [responseObject objectForKey:@"msg"];
//            if ([[responseObject objectForKey:@"code"] integerValue]!=0) {
//                [weakSelf.view toastShow:strMsg];
//                return;
//            }else{
//                [weakSelf pusuToVc:indexPath.item];
//            }
//        } Failure:^(NSError *error) {
//            [weakSelf.view toastShow:netFailString];
//        }];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    // setToast(@"值改变操作");
    if (![UIApplication sharedApplication].idleTimerDisabled) {
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
}
-(void)dealloc{
//    [[UIApplication sharedApplication] removeObserver:self forKeyPath:@"idleTimerDisabled"];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    NSLog(@"=======%s销毁了",__func__);
}

-(void)click_adv:(UITapGestureRecognizer*)tap{
    NSString *str = self.systemMessage[@"link"];
    if (!str.length) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    SVCPlayerWebViewController *targent = [[SVCPlayerWebViewController alloc] initWithPlayUrl:str];
//    targent.title = @"威尼斯人";
//    [self.navigationController pushViewController:targent animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)giftDidRemove:(LiveGiftShowModel *)showModel {
    WLog(@"用户：%@ 送出了 %li 个 %@", showModel.user.name, showModel.currentNumber, showModel.giftModel.name);
}

/*
 礼物视图支持很多配置属性，开发者按需选择。
 */
- (LiveGiftShowCustom *)customGiftShow{
    if (!_customGiftShow) {
        _customGiftShow = [LiveGiftShowCustom addToView:self.view];
        _customGiftShow.addMode = LiveGiftAddModeAdd;
        [_customGiftShow setMaxGiftCount:3];
        [_customGiftShow setShowMode:LiveGiftShowModeFromTopToBottom];
        [_customGiftShow setAppearModel:LiveGiftAppearModeLeft];
        [_customGiftShow setHiddenModel:LiveGiftHiddenModeNone];
        [_customGiftShow enableInterfaceDebug:YES];
        _customGiftShow.delegate = self;
    }
    return _customGiftShow;
}

- (LiveUserModel *)fifthUser {
    if (!_fifthUser) {
        _fifthUser = [[LiveUserModel alloc]init];
        _fifthUser.name = [SVCUserInfoUtil mGetUser].nickname;
        _fifthUser.iconUrl = nil;
    }
    return _fifthUser;
}

@end
