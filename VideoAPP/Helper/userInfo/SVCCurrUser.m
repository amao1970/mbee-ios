//
//  SVCCurrUser.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCCurrUser.h"
@implementation SVCCurrUser

#pragma mark 编码 对user属性进行编码的处理
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.nickname_code forKey:@"nickname_code"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.invite_code forKey:@"invite_code"];
    [aCoder encodeObject:self.is_ever forKey:@"is_ever"];
    [aCoder encodeObject:self.end_time forKey:@"end_time"];
    [aCoder encodeObject:self.is_end forKey:@"is_end"];
    [aCoder encodeObject:self.token forKey:@"token"];
  
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.nickname_code = [aDecoder decodeObjectForKey:@"nickname_code"];
        self.invite_code = [aDecoder decodeObjectForKey:@"invite_code"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.is_ever = [aDecoder decodeObjectForKey:@"is_ever"];
        self.end_time = [aDecoder decodeObjectForKey:@"end_time"];
         self.is_end = [aDecoder decodeObjectForKey:@"is_end"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
    }
    return self;
}

+(instancetype)mInitUserWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self == [super init]) {
        self.username = dic[@"username"];
        self.avatar = dic[@"avatar"];
        self.nickname_code = dic[@"nickname_code"];
        self.invite_code = dic[@"invite_code"];
        self.nickname = dic[@"nickname"];
        self.is_ever = dic[@"is_ever"];
        self.end_time = dic[@"end_time"];
        self.is_end = dic[@"is_end"];
        self.uid = dic[@"uid"];
        self.token = dic[@"token"];
    }
    return self;
}

+(void)SaveLoginInfoToken:(NSString *)token
           andPhoneNumber:(NSString *)PhoneNumber
                andUserID:(NSString *)UserID
              andPassword:(NSString *)Password
             andLoginType:(NSString *)LoginType
{

    NSUserDefaults *ud= [NSUserDefaults standardUserDefaults];
    [ud setObject:token forKey:@"token"];
    [ud setObject:PhoneNumber forKey:@"phone_number"];
    [ud setObject:UserID forKey:@"uid"];
    if (LoginType.length>0) {
        [ud setObject:LoginType forKey:@"LoginType"];
    }
    if (Password.length>0) {
        [ud setObject:Password forKey:@"loginPassWord"];
    }
    
    [ud setObject:PhoneNumber forKey:@"loginPhontNumber"];
    [ud synchronize];
}

+ (void)changePassword:(NSString *)password
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"loginPassWord"];
    [ud setObject:password forKey:@"loginPassWord"];
    [ud synchronize];
}

+ (void)deledateToken:(NSString *)token
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"token"];
    [ud synchronize];
}
@end
