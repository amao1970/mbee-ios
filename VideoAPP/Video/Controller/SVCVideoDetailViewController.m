//
//  SVCVideoDetailViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCVideoDetailViewController.h"

#import "SVCVideoDetailHeadView.h"
#import "SVCVideoDetailTableView.h"

//#import "ZFPlayer.h"
//#import "ZFAVPlayerManager.h"
//#import "ZFIJKPlayerManager.h"
//#import "KSMediaPlayerManager.h"
//#import "ZFPlayerControlView.h"
//#import "ZFSmallPlayViewController.h"
//#import "UIImageView+ZFCache.h"
//#import "ZFUtilities.h"

#import "JXVideoInfoModel.h"
#import "JXVideoListModel.h"

// vc
#import "VDUserCenterVC.h"

#import <JWPlayer_iOS_SDK/JWPlayerController.h>

@interface SVCVideoDetailViewController ()<SVCVideoDetailTableViewDelegate>
@property (nonatomic) JWPlayerController *player;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
//@property (nonatomic, strong) ZFPlayerController *player;
//@property (nonatomic, strong) UIImageView *containerView;
//@property (nonatomic, strong) ZFPlayerControlView *controlView;
//@property (nonatomic, strong) UIButton *playBtn;
//@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;

@property (nonatomic, strong) SVCVideoDetailTableView * tableView;
@property (nonatomic, strong) SVCVideoDetailHeadView * headView;

@property (nonatomic, assign) BOOL isStreamline;
@property (nonatomic, assign) BOOL isDownloadIng;

@end

@implementation SVCVideoDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT );
    self.tableView = [[SVCVideoDetailTableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.JXDelegate = self;
    [self.view addSubview:self.tableView];
    
    self.headView = [SVCVideoDetailHeadView getViewFormNSBunld];
    self.headView.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(408));
    self.headView.show.selected = YES;
    [self.headView.show addTarget:self action:@selector(headViewShow:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.headView.advBtn.userInteractionEnabled = YES;
    [self.headView.advBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_adv)]];
    
    self.headView.advImg.userInteractionEnabled = YES;
    [self.headView.advImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_advImg)]];
    
    [self.headView.shareBtn addTarget:self action:@selector(click_share) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.downloadBtn addTarget:self action:@selector(click_download) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.close_advImg addTarget:self action:@selector(click_closeAdvImg) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.userBtn addTarget:self action:@selector(click_userBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.collection addTarget:self action:@selector(click_collection) forControlEvents:UIControlEventTouchUpInside];
    self.headView.show.selected = YES;
    
    [self setUpMainView];
    [self getNetData];
    [self getAdvInfoData];
    [self getVideoAdvNetData];
}

-(void)click_adv{
    NSString *url = self.headView.bannerInfo[@"link"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

-(void)click_share{
    SVCinvateFriendsViewController *targent = [[SVCinvateFriendsViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

- (void)setUpMainView {
    [self.headView bringSubviewToFront:self.headView.advImg];
    [self.headView bringSubviewToFront:self.headView.close_advImg];
}


-(void)SVCVideoDetailTableViewDidSelect:(NSIndexPath *)indexPath
{
    SVCVideoDetailViewController *targent = [[SVCVideoDetailViewController alloc] init];
    targent.videoID = self.tableView.dataAry[indexPath.row].id;
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)SVCVideoDetailTableViewDidSelect:(NSIndexPath *)indexPath Tag:(NSInteger)tag
{
    SVCSearchViewController *targent = [[SVCSearchViewController alloc] init];
    targent.searchInfo = @{@"type":@"2",@"content":self.tableView.dataAry[indexPath.row].tag[tag]};
    [self.navigationController pushViewController:targent animated:YES];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
////    if (self.player.isFullScreen) {
////        return UIStatusBarStyleLightContent;
////    }
//    return UIStatusBarStyleDefault;
//}

//- (BOOL)prefersStatusBarHidden {
//    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
//    return self.player.isStatusBarHidden;
//}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

//- (BOOL)shouldAutorotate {
//    return self.player.shouldAutorotate;
//}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    if (self.player.isFullScreen) {
//        return UIInterfaceOrientationMaskLandscape;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}

-(void)click_advImg{
    NSString *url = self.tiepianLink;
    NSLog(@"===========>%@", self.tiepianLink);
    NSLog(@"===========>%@", url);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

-(void)click_closeAdvImg{
    [self.headView.advImg removeFromSuperview];
    [self.headView.close_advImg removeFromSuperview];
    [self.player play];
}

-(void)click_download{
    if (self.isDownloadIng) {
        [self.view toastShow:@"视频正在下载加..."];
        return;
    }
    
    NSData *data = [self xor_encrypt:[self.headView.videoDetailInfo.link dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *link = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", cachesPath, [link lastPathComponent]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:fullPath]) {
        BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([[NSURL URLWithString:fullPath] path]);
        if (compatible)
        {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum([[NSURL URLWithString:fullPath] path], self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
        }
        //        [self.view toastShow:@"视频保存到相册"];
        NSLog(@"存在");
        return;
        
    }
    else {
        NSLog(@"文件不存在");
    }
    [self.view toastShow:@"开始缓存"];
    self.isDownloadIng = YES;
    [SVCCommunityApi downloadFileWithRequestUrl:link FileName:[link lastPathComponent] Complete:^(NSURL *filePath, NSError *error) {
        BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([filePath path]);
        if (compatible)
        {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum([filePath path], self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
        }
        self.isDownloadIng = NO;
    } Progress:^(id downloadProgress, double currentValue) {
        if (currentValue < 1) {
            self.isDownloadIng = NO;
        }else{
            self.isDownloadIng = YES;
        }
        NSLog(@"download %@-%f;",downloadProgress,currentValue);
    }];
}


//保存视频完成之后的回调
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
    }
    else {
        [self.view toastShow:@"视频已缓存到相册"];
        NSLog(@"保存视频成功");
    }
}

-(void)getNetData{
    
    NSDictionary *dic = @{@"id": self.videoID};
    
    NSString *url = @"/mobile/video/info";
    if (self.isPreview) {
        url = @"/mobile/video/infos";
    }
    [JXAFNetWorking method:url parameters:dic finished:^(JXRequestModel *obj) {
        self.headView.videoDetailInfo = [[JXVideoInfoModel alloc] initWithDictionary:[obj getResultDictionary][@"videoinfo"] error:nil];
        [self headViewShow:self.headView.show];;
        self.tableView.dataAry = [JXVideoListModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"videoLists"]];
        if (self.headView.videoDetailInfo.sc.integerValue == 1) {
            self.headView.collection.selected = YES;
        }else{
            self.headView.collection.selected = NO;
        }
        
        NSData *data = [self xor_encrypt:[self.headView.videoDetailInfo.link dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *link = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        JWConfig *config = [[JWConfig alloc] init];
        config.file = link;
        self.player = [[JWPlayerController alloc] initWithConfig:config];
        self.player.view.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_WIDTH/16.0f*9);
        [self.headView addSubview:self.player.view];
        [self.headView bringSubviewToFront:self.headView.advImg];
        [self.headView bringSubviewToFront:self.headView.close_advImg];
    } failed:^(JXRequestModel *obj) {
        
    }];
//    [SVCCommunityApi getVideoInfoWithParams:dic BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
//        if (code == 0) {
//
//        }
//    } andfail:^(NSError *error) {
//
//    }];
}

-(void)getVideoAdvNetData{
    [SVCCommunityApi GetVideoAdvInfoWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
//            NSDictionary *dic = JSON;
            NSString *img = JSON[@"image"];
            if (img && img.length) {
                self.tiepianLink = JSON[@"link"];
                NSLog(@"2222222222222=>%@", self.tiepianLink)
                
                self.headView.advImg.hidden = NO;
                [self.headView.advImg sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"默认图"]];
                
                self.time = [JSON[@"closeTime"] integerValue];
                //self.time = 500;
                [self.headView.close_advImg setTitle:[NSString stringWithFormat:@"%ld秒后开始播放",self.time] forState:UIControlStateNormal];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer_close) userInfo:nil repeats:YES];
                self.headView.close_advImg.hidden = NO;
                [self.headView bringSubviewToFront:self.headView.advImg];
                [self.headView bringSubviewToFront:self.headView.close_advImg];
                
                
            }else{
                self.headView.advImg.hidden = YES;
                self.headView.close_advImg.hidden = YES;
                self.headView.advImg.hidden = YES;
                self.headView.close_advImg.hidden = YES;
            }
        }else{
            
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        
    }];
}

-(void)timer_close{
    self.time--;
    [self.headView.close_advImg setTitle:[NSString stringWithFormat:@"%ld秒后开始播放",self.time] forState:UIControlStateNormal];
    
    if (self.time <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self click_closeAdvImg];
        
    }
}

-(void)getAdvInfoData{
    [SVCCommunityApi getVideoAdvWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        if (code == 0) {
            self.headView.bannerInfo = json;
        }
    } andfail:^(NSError *error) {
        
    }];
}

-(void)click_userBtn{
    VDUserCenterVC *targent = [[VDUserCenterVC alloc] init];
    targent.userID = self. self.headView.videoDetailInfo.authorid ;
    [self.navigationController pushViewController:targent animated:YES];
}

-(void)headViewShow:(UIButton*)btn{
    btn.selected = !btn.isSelected;
    [self.headView setUpShow];
    self.tableView.tableHeaderView = self.headView;
}

-(void)click_collection{
    [WsHUD showHUDWithLabel:@"正在提交..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking method:@"/mobile/video/tlike" parameters:@{@"id":self.headView.videoDetailInfo.id} finished:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        self.headView.collection.selected = !self.headView.collection.isSelected;
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];
}
static NSString *secretKey =@"32154623145613678979315646";
// 加密
- (NSData *)xor_encrypt:(NSData *)value
{
    // 获取key的长度
    NSInteger length = secretKey.length;
    // 将OC字符串转换为C字符串
    const char *keys = [secretKey cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cKey[length];
    memcpy(cKey, keys, length);
    // 数据初始化，空间未分配 配合使用 appendBytes
    NSMutableData *encryptData = [[NSMutableData alloc] initWithCapacity:length];
    // 获取字节指针
    const Byte *point = value.bytes;
    for (int i = 0; i < value.length; i++) {
        int l = i % length;                     // 算出当前位置字节，要和密钥的异或运算的密钥字节
        char c = cKey[l];
        Byte b = (Byte) ((point[i]) ^ c);       // 异或运算
        [encryptData appendBytes:&b length:1];  // 追加字节
    }
    return encryptData.copy;
}

@end
