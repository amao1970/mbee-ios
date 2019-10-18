//
//  SVCCommunityApi.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCCommunityApi.h"
#import "BKNetworkHelper.h"
@implementation SVCCommunityApi

#pragma mark --> 初始化网络请求对象
+ (BKNetworkHelper *)initNetHelper
{
    return [BKNetworkHelper shareInstance];
}

#pragma mark --> 获取验证码
+ (void)GetAuthCodeWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/sms/send"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
    
}

#pragma mark --> 获取是否需要验证码
+ (void)GetSmsMopenWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/sms/smsmopen"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
    
}

#pragma mark --> 注册账号
+ (void)RegUserWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/user/register"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
          NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
       fail(error);
    }];
}

#pragma mark --> 账户登录
+ (void)LoginWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
     NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/user/login"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *JSON = responseObject[@"data"];
        success(result,message,JSON);
        SVCCurrUser *userIn = [SVCCurrUser mj_objectWithKeyValues:JSON];
        [SVCUserInfoUtil mSaveUser:userIn];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"login" object:nil];
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 退出登录
+(void)LogoutWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/user/logout"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"logout" object:nil];
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 重置密码
+ (void)ResetPasswordWithNSDictionary:(NSDictionary *)parameters type:(NSString *)type  BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@/%@",BASE_API,@"/mobile/user/",type];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 邀请好友
+ (void)inviteFriendswithNSDiction:(NSDictionary *)parameters 
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail
{
     NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/user/invite"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
         success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
         fail(error);
    }];
}

#pragma mark --> 邀请好友
+ (void)inviteFriendsDetailwithNSDiction:(NSDictionary *)parameters
                            BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                 andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/promotion/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --> 获取客服信息
+ (void)GetcustomerInfoWithNSDiction:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/user/customer"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取影视广告
+ (void)GetVideoAdvInfoWithNSDiction:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/adv/video_tiepian"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 会员续费
+ (void)UserrechargefoWithNSDiction:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/card/recharge"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取bannerList
+ (void)GetBannerListWithNSDiction:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
      NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/adv/banner"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取版本更新
 + (void)CheckUpdateWithNSDiction:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/index/checkUpdate"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
                NSLog(@" 版本更新 %@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取广告图片
+ (void)getADImageWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/adv/start"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取精彩视频
+ (void)getWonderfulVideoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/video/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 检测用户是否是vip
+ (void)checkVIPWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/index/checkUser"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 检测用户是否是vip-直播
+ (void)checkLiveVIPWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/index/checkUser/?live=1"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取直接间广告
+ (void)getOnbordCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/adv/live"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取影视分类
+ (void)getVideoCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/video/cateList"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取电影分类
+ (void)getMovieCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/movie/cateList"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取图片分类
+ (void)getImageCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/picture/cateList"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取图片列表
+ (void)getImageListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/picture/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"lists"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取小说列表
+ (void)getVideoListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/video/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"lists"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取小说分类
+ (void)getNovelCategoryWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/news/cateList"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取小说列表
+ (void)getNovelListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/news/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"lists"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取VIP影院
+ (void)getVIPMoviceUrlWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSString *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/tv/vip"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"tv_vip_link"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --> 获取卫视直播
+ (void)getTVUrlWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSString *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/tv/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"tv_link"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取图片详情
+ (void)getImgInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/picture/info"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取小说详情
+ (void)getnoveInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/news/info"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取小说详情
+ (void)getShareInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/share/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

+ (void)getShareSuccessedWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/share/callback"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

+ (void)getVerifyCodeImageWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BASE_API,@"/mobile/Verify/index/d_id/",parameters[@"d_id"]];
    [[self initNetHelper] GET:url Parameters:nil Success:^(id responseObject) {
        NSLog(@"url == %@  responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取广告政策
+ (void)getadvInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/adv/hezuo"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取首页数据
+ (void)getHomePageDataWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/index/zonghe"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取搜索数据
+ (void)getSearchDataWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/index/search"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取搜索热门
+ (void)getSearchHotListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/index/taglist"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取推荐主播
+ (void)getRecommendWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/live/tuijian"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取回放
+ (void)getReplayListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/play/huifang"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取全部主播
+ (void)getAllLiveWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/live/quanbu"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取视频详情
+ (void)getVideoInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/video/info"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取视频广告
+ (void)getVideoAdvWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/adv/video_pic"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取电影列表
+ (void)getMoviewListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/movie/index"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"lists"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --> 获取视频详情
+ (void)getMovieInfoWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/movie/info"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

+(void)downloadFileWithRequestUrl:(NSString *)url
                         FileName:(NSString *)fileName
                         Complete:(void (^)(NSURL *filePath, NSError *error))complete
                         Progress:(void (^)(id downloadProgress, double currentValue))progress
{
    [[self initNetHelper] downloadFileWithRequestUrl:url FileName:fileName Complete:complete Progress:progress];
}

#pragma mark --> 帮助
+ (void)getHelpListWithParams:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSArray *))success andfail:(void (^)(NSError *))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/help/lists"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"url == %@  parameters == %@ responseObject == %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        NSDictionary *data = responseObject[@"data"];
        success(result,message,data[@"lists"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -->
+ (void)UserUpdateHeadImgWithNSDiction:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/User/updateavatar"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -->
+ (void)UserHelpInfoWithNSDiction:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/help/info"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -->
+ (void)UserReportWithNSDiction:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/User/agent"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -->
+ (void)UserUpdateNickNameWithNSDiction:(NSDictionary *)parameters
                          BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                               andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/User/updatenick"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    }];
}

@end
