//
//  SVCPlayerViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCPlayerViewController.h"
#import "WMPlayer.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "TXScrollLabelView.h"
#import "SVCVideoAdvInfoModel.h"

@interface SVCPlayerViewController ()<WMPlayerDelegate,TXScrollLabelViewDelegate>
@property(nonatomic, copy) NSString *videoUrl; /**<<#属性#> */

@property(nonatomic, strong) WMPlayer *player; /**<<#属性#> */

@property (nonatomic , weak)TXScrollLabelView *scrollLabelView;
@property (nonatomic,weak) UIView *paomaView;
@property (nonatomic, strong) SVCVideoAdvInfoModel *advDataInfo;

@end

@implementation SVCPlayerViewController

- (instancetype)initWithVideoUrl:(NSString *)videoUrl{
    if (self = [super init]) {
        _videoUrl = videoUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    WMPlayerModel *playerModel = [[WMPlayerModel alloc] init];
    playerModel.videoURL = [NSURL URLWithString:_videoUrl];
    self.player = [[WMPlayer alloc] initPlayerModel:playerModel];

    [self.view addSubview:self.player];
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
    self.player.isFullscreen = YES;
    self.player.backBtnStyle = BackBtnStylePop;
    self.player.enableVolumeGesture = YES;
    self.player.enableFastForwardGesture = YES;
    self.player.delegate = self;
    self.player.tintColor = SVCMainColor;
    NSLog(@"isLockScreen == %d", self.player.isLockScreen);
    [self.player play];
    
    [self getVideoAdvInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    
}

- (void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)backBtn{
//    [self removeFromParentViewController];
//    [UIApplication sharedApplication].windows[1].hidden = YES;
//    [UIApplication sharedApplication].windows[1].rootViewController = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//支持旋转
 -(BOOL)shouldAutorotate{
    return YES;
}
 //
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)dealloc{
    [self.player pause];
    [self.player removeFromSuperview];
    self.player = nil;
    NSLog(@"播放器界面释放了");
}

- (void)getVideoAdvInfo
{
    WS(weakSelf);
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    [SVCCommunityApi GetVideoAdvInfoWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            self.advDataInfo = [SVCVideoAdvInfoModel mj_objectWithKeyValues:JSON];
            self.scrollLabelView.scrollTitle = self.advDataInfo.adtext;
            [self.scrollLabelView beginScrolling];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}

- (UIView *)paomaView
{
    if (!_paomaView) {
        UIView *viewAnima = [[UIView alloc] init];
        viewAnima.backgroundColor = [UIColor  blackColor];
        viewAnima.alpha = 0.30;
//        WS(weakSelf);
        UIView *content =[self.player viewWithTag:888];
        UIView *topView =[self.player viewWithTag:999];
        [content insertSubview:viewAnima belowSubview:topView];
        [viewAnima mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content.mas_left).offset(0);
            make.right.equalTo(content.mas_right).offset(0);
            make.top.equalTo(content.mas_top).offset(0);
            make.height.equalTo(@(30));
        }];
        _paomaView.userInteractionEnabled = YES;
        [_paomaView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action: @selector(push_adv)]];
        _paomaView = viewAnima;
    }
    return _paomaView;
}

-(TXScrollLabelView *)scrollLabelView{
    if (!_scrollLabelView) {
        TXScrollLabelView *TXView = [TXScrollLabelView scrollWithTitle:@"" type:TXScrollLabelViewTypeLeftRight velocity:1.5 options:UIViewAnimationOptionCurveEaseInOut];;
        TXView.tx_centerX  = (kScreenWidth - 30) * 0.5;
        TXView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        TXView.scrollSpace = 10;
        TXView.font = [UIFont systemFontOfSize:14];
        TXView.textAlignment = NSTextAlignmentCenter;
        TXView.scrollTitleColor = [UIColor whiteColor];
        TXView.layer.cornerRadius = 5;
        TXView.frame = CGRectMake(30, 0, kScreenWidth - 30, 30);
        TXView.scrollLabelViewDelegate = self;
        [self addTopview];
        [self.paomaView addSubview:TXView];
        _scrollLabelView = TXView;
    }
    return _scrollLabelView;
}

- (void)addTopview
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
    imageView.image = [UIImage imageNamed:@"icon_gonggao"];
    [self.paomaView addSubview:imageView];
}

-(void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index
{
    [self push_adv];
}

-(void)push_adv{
    NSString *str = self.advDataInfo.link;
    if (!str.length) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


@end
