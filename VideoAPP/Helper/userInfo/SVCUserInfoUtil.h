//
//  SVCUserInfoUtil.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVCCurrUser.h"
@interface SVCUserInfoUtil : NSObject

//保存用户信息
+(void)mSaveUser:(SVCCurrUser *)user;

//获取用户信息
+ (SVCCurrUser *)mGetUser;

+ (void)deleteFile;
@end
