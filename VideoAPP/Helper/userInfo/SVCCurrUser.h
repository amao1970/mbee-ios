//
//  SVCCurrUser.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVCCurrUser : NSObject <NSCoding>

@property (copy, nonatomic) NSString *username;//用户名
@property (copy, nonatomic) NSString *avatar;//用户头像
@property (copy, nonatomic) NSString *nickname_code;//昵称标识码
@property (copy, nonatomic) NSString *invite_code;
@property (copy, nonatomic) NSString *nickname;//昵称
@property (nonatomic , copy)NSString *is_ever;//是否是终身会员，0：否；1：是
@property (nonatomic , copy)NSString *end_time;//VIP到期时间
@property (nonatomic ,copy)NSString *is_end;//VIP是否过期，0：未过期；1：已过期
@property (nonatomic ,copy)NSString *uid;//用户id
@property (nonatomic ,copy)NSString *token;//用户id
@property (nonatomic ,copy)NSString *is_agent;//是否是代理
@property (nonatomic ,copy)NSString *payAccount;//是否是代理

+(instancetype)mInitUserWithDic:(NSDictionary *)dic;

//保存登录信息
+(void)SaveLoginInfoToken:(NSString *)token
           andPhoneNumber:(NSString *)PhoneNumber
                andUserID:(NSString *)UserID
              andPassword:(NSString *)Password
             andLoginType:(NSString *)LoginType;
//修改个人信息
+(void)changePassword:(NSString *)password;

//删除token
+ (void)deledateToken:(NSString *)token;
@end
