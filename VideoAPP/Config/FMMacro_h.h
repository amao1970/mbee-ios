//
//////////////////////////////////////////////////////////
//                                                      //
//                 阿里聚合直播盒子系统                 // 
//                                                      //
//                 官网：www.alijuhe.net                //
//                                                      //
//                  Q Q:81236693                        //
//                                                      //
//////////////////////////////////////////////////////////
//

#ifndef FMMacro_h_h
#define FMMacro_h_h
#import "SVCCommunityApi.h"
#import "SVCCurrUser.h"
#import "SVCUserInfoUtil.h"

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kstatueHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define SystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kAppStatusBarHeight kstatueHeight + 44

#define iphoneX ([UIScreen mainScreen].bounds.size.height == 812.0f)
#define  kTabbarHeight  (KIsiPhoneX ? (49.f+34.f) : 49.f)
#define Knavheight (KIsiPhoneX ? 88 : 64)
#define kFont(a) [UIFont systemFontOfSize:a]
#define NetWork4G @"NetWork4G"
#define NetWorkWifi @"NetWorkWifi"
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 颜色
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define BtnbgColor   [UIColor hexStringToColor:@"#f75858"]
//弱引用
#define WS(weakSelf)  __weak __typeof(self)weakSelf = self;

#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define NSLog(...) printf("%s 第%d行: %s\n\n", [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define NSLog(...)
#endif

#define NoNetAlertString @"网络状态不佳"//网络状态提示语
#define NoshowInfoString @"功能正在更新中，敬请期待!"//提示正在开发中
#define netFailString @"服务器出小差了，请重试"//服务器出小差了，请重试

#define showImage(image)[UIImage imageNamed:image]

#endif /* FMMacro_h_h */
