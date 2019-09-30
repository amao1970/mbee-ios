//
//  AppDelegate.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "AppDelegate.h"
#import "SVCTabBarController.h"
#import "JXTabBarController.h"
#import "SVCLoginViewController.h"
#import "SVCADViewController.h"
#import "XHLaunchAd.h"
//#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
//#import "UMMobClick/MobClick.h"

#import <JWPlayer_iOS_SDK/JWPlayerController.h>

static NSString * const VIDEO_CONTROLLER_CLASS_NAME_IOS7 = @"MPInlineVideoFullscreenViewController";
static NSString * const VIDEO_CONTROLLER_CLASS_NAME_IOS8 = @"AVFullScreenViewController";

@interface AppDelegate ()<XHLaunchAdDelegate>
@property(nonatomic, strong) XHLaunchAd *launchAd; /**<属性 */
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [JWPlayerController setPlayerKey:@"Kj6qMQC/Y4sIX3UsyE4/lDScSUzRQQ/GUcJPOV9bI0v+sZUZ"];
    [JWPlayerController SDKVersion];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    JXTabBarController *tab = [[JXTabBarController alloc] init];
    _window.rootViewController = tab;
    
    [self cofigureADImage]; // 配置广告页
    [self configUMShare];
    [_window makeKeyAndVisible];
    
    
    return YES;
}

- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    NSLog(@"openModel == %@", openModel);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:openModel]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openModel]];
    }
}

- (void)configUMShare{
    /* 设置友盟appkey */
    [UMConfigure setLogEnabled:NO];
    [UMConfigure initWithAppkey:UMAppkey channel:@"App Store"];
    
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    
    // 友盟分享调试日志
    [[UMSocialManager defaultManager] openLog:NO];
    [MobClick setCrashReportEnabled:YES];   // 关闭Crash收集
    //关闭强制验证https
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
//    
//    [UMConfigure initWithAppkey:UMAppkey channel:@""];
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    // 统计组件配置
//    [MobClick setScenarioType:E_UM_NORMAL];
    
    // 友盟分享调试日志
//    [[UMSocialManager defaultManager] openLog:NO];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:WeixinAppId
                                       appSecret:WeixinSecret
                                     redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQAppId
                                       appSecret:QQSecret
                                     redirectURL:@"http://mobile.umeng.com/social"];
}

- (void)cofigureADImage{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:2];
    [SVCCommunityApi getADImageWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        // 有图片进入广告页
        if (code == 0) {
            //配置广告数据
            XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageOption = XHLaunchAdImageCacheInBackground;
            imageAdconfiguration.imageNameOrURLString = [json objectForKey:@"image"];
            //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
            imageAdconfiguration.openModel = [json objectForKey:@"link"];
            //显示开屏广告
           self.launchAd = [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
            self.launchAd.delegate = self;
        }
    } andfail:^(NSError *error) {
        // 没有图片不处理
    }];
}


- (void)PresentLoginviewController
{
    SVCLoginViewController *loginVC = [[SVCLoginViewController alloc] init];
      [loginVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.window.rootViewController presentViewController:loginVC animated:YES completion:^{
        
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
