//
//  SVCCommunityApi.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVCCommunityApi : NSObject
typedef void (^Failure)(NSError *failure);
#pragma mark --> 获取验证码
+(void)GetAuthCodeWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;
#pragma mark --> 获取是否需要验证码
+ (void)GetSmsMopenWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 注册账号
+(void)RegUserWithNSDictionary:(NSDictionary *)parameters
                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                       andfail:(void (^)(NSError *error))fail;

#pragma mark --> 账户登录
+(void)LoginWithNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail;

#pragma mark --> 退出登录
+(void)LogoutWithNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail;

#pragma mark --> 重置密码
+(void)ResetPasswordWithNSDictionary:(NSDictionary *)parameters type:(NSString *)type
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;

#pragma mark --> 邀请好友
+ (void)inviteFriendswithNSDiction:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;
#pragma mark --> 邀请好友
+ (void)inviteFriendsDetailwithNSDiction:(NSDictionary *)parameters
                            BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                 andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取客服信息
+ (void)GetcustomerInfoWithNSDiction:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 会员续费
+ (void)UserrechargefoWithNSDiction:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取bannerlist数据
+ (void)GetBannerListWithNSDiction:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 检测版本更新
+ (void)CheckUpdateWithNSDiction:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取广告图片
+ (void)getADImageWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取直接间广告
+ (void)getOnbordCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取精彩视频
+ (void)getWonderfulVideoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 检测用户是否是vip
+ (void)checkVIPWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取小说列表
+ (void)getVideoListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取影视分类
+ (void)getVideoCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取小说分类
+ (void)getNovelCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取小说列
+ (void)getNovelListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取VIP影院
+ (void)getVIPMoviceUrlWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSString *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取卫视直播
+ (void)getTVUrlWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSString *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取小说详情
+ (void)getnoveInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取分享详情
+ (void)getShareInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;

+ (void)getShareSuccessedWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;

+ (void)getVerifyCodeImageWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取图片分类
+ (void)getImageCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取图片列表
+ (void)getImageListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取广告政策
+ (void)getadvInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取首页数据
+ (void)getHomePageDataWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取图片详情
+ (void)getImgInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取搜索数据
+ (void)getSearchDataWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取影视广告
+ (void)GetVideoAdvInfoWithNSDiction:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;
#pragma mark --> 获取搜索热门
+ (void)getSearchHotListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;

#pragma mark --> 获取推荐主播
+ (void)getRecommendWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取全部主播
+ (void)getAllLiveWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取回放
+ (void)getReplayListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取视频详情
+ (void)getVideoInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 获取视频广告
+ (void)getVideoAdvWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;

#pragma mark --> 获取电影分类
+ (void)getMovieCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;

#pragma mark --> 获取电影列表
+ (void)getMoviewListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;

#pragma mark --> 获取电影详情
+ (void)getMovieInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail;
#pragma mark --> 帮助
+ (void)getHelpListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail;
#pragma mark -->
+ (void)UserUpdateHeadImgWithNSDiction:(NSDictionary *)parameters
                          BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                               andfail:(void (^)(NSError *error))fail;
#pragma mark -->
+ (void)UserHelpInfoWithNSDiction:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail;
#pragma mark -->
+ (void)UserReportWithNSDiction:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail;
#pragma mark -->
+ (void)UserUpdateNickNameWithNSDiction:(NSDictionary *)parameters
                           BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                andfail:(void (^)(NSError *error))fail;
+(void)downloadFileWithRequestUrl:(NSString *)url
                         FileName:(NSString *)fileName
                         Complete:(void (^)(NSURL *filePath, NSError *error))complete
                         Progress:(void (^)(id downloadProgress, double currentValue))progress;
@end
