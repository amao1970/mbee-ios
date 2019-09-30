//
//  SVCShareViewController.m
//  SmartValleyCloudSeeding
//
//  Created by Mac on 2018/8/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCShareTimeViewController.h"
#import "SVCCommunityApi.h"
#import "SVCShareModel.h"
#import "MJExtension.h"
#import "SVCShareView.h"
//#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import "SVCUserInfoUtil.h"
#import "SVCCurrUser.h"
#import <SDWebImageDownloader.h>
@interface SVCShareTimeViewController ()<SVCShareViewDelegate>
@property (strong, nonatomic) SVCShareModel *model;
@end

@implementation SVCShareTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.type isEqualToString:@"1"]) {
        [self checkLogin];
    }
    [self fetchShareData];
    
}

- (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return rect.size.height;
}
- (void)setupShareView{
    CGFloat contextH = [self getLabelHeightWithText:self.model.share_rule width:SCREEN_WIDTH - 40 font:13];
    
    self.view.backgroundColor =SVCColorFromRGB(0xf5f5f5);
    UIView *topView  = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, contextH + 80 )];
    topView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 20, 18)];
    titleLabel.text = @"分享规则：";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = SVCColorFromRGB(0xff8fa2);
    [topView addSubview:titleLabel];
    
    UILabel *contextLabel = [[UILabel alloc] init];
    contextLabel.font = [UIFont systemFontOfSize:13];
    contextLabel.textColor = SVCColorFromRGB(0xff8fa2);
    contextLabel.numberOfLines = 0;
    contextLabel.x = 20;
    contextLabel.width = SCREEN_WIDTH - 40;
    contextLabel.y = CGRectGetMaxY(titleLabel.frame) + 20;
    contextLabel.height = contextH;
    contextLabel.text = self.model.share_rule;
    [topView addSubview:contextLabel];
    [self.view addSubview:topView];
    
    SVCShareView *shareView = [SVCShareView shareView];
    shareView.delegate = self;
    shareView.X = 0;
    shareView.y = CGRectGetMaxY(topView.frame) + 10;
    shareView.width = SCREEN_WIDTH;
    shareView.height = 160;
    [self.view addSubview:shareView];
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

- (void)fetchShareData{
    SVCWeakSelf;
    [WsHUD showHUDWithLabel:@"正在加载数据中" modal:YES timeoutDuration:20.0];
    [SVCCommunityApi getShareInfoWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        [WsHUD hideHUD];
        if (code == 0) {
        weakSelf.model  = [SVCShareModel mj_objectWithKeyValues:json];
            
        [self setupShareView];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
    }];
}
- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareView:(SVCShareView *)shareView didClickButtonWithIndex:(NSInteger)index{
    
    UMSocialPlatformType platformType;
    switch (index) {
        case 0:
            platformType = UMSocialPlatformType_WechatSession;
            break;
        case 1:
            platformType = UMSocialPlatformType_QQ;
            break;
        case 2:
            platformType = UMSocialPlatformType_WechatTimeLine;
            break;
        case 3:
            platformType = UMSocialPlatformType_Qzone;
            break;
        default:
            platformType = UMSocialPlatformType_WechatSession;
            break;
    }
    
    if (![[UMSocialManager defaultManager] isInstall:platformType]) {
        [self.view toastShow:@"该应用未安装,无法分享"];
        return ;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString* thumbURL =  self.model.share_img;
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.share_title descr:self.model.share_desc thumImage:thumbURL];

    //设置网页地址
    shareObject.webpageUrl = self.model.share_link;
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.model.share_img] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        //分享消息对象设置分享内容对象
        shareObject.thumbImage = data;
        messageObject.shareObject = shareObject;
        //调用分享接口
        SVCWeakSelf;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    NSLog(@"分享成功");
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    [SVCCommunityApi getShareSuccessedWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
                        if (code == 0) {
                            [weakSelf.view toastShow:@"分享成功"];
                            if ([json isKindOfClass:[NSDictionary class]]) {
                                NSString *endTime = [NSString stringWithFormat:@"%@",[json objectForKey:@"end_time"]];
                                SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
                                user.end_time = endTime;
                                [SVCUserInfoUtil mSaveUser:user];
                                
                                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                                [center postNotificationName:@"shareSuccessed" object:nil];
                            }
                        }else{
                            [weakSelf.view toastShow:@"分享失败了，可以尝试再次分享获得奖励哦"];
                        }
                    } andfail:^(NSError *error) {
                        [weakSelf.view toastShow:@"网络出了一点小状况~"];
                    }];
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }];
}


@end
