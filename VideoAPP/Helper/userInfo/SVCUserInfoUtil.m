//
//  SVCUserInfoUtil.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCUserInfoUtil.h"
#import "ToolClass.h"

static SVCCurrUser *currUser;
#define DEF_USER_DATA @"user.db"
@implementation SVCUserInfoUtil


//保存用户信息
+(void)mSaveUser:(SVCCurrUser *)user{
    NSString *cachePath = [ToolClass getLibraryCachesPath:DEF_USER_DATA];
    BOOL result = [NSKeyedArchiver archiveRootObject:user toFile:cachePath]; //归档
    if (result) {
        currUser = user;
    }
}

//获取用户信息
+(SVCCurrUser *)mGetUser{
    if (nil != currUser) {
        return currUser;
    }
    NSString *cachePath = [ToolClass getLibraryCachesPath:DEF_USER_DATA];
    SVCCurrUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
    return user;
}
+ (void)deleteFile
{
    // 获取要删除的路径
    NSString *deletePath = [ToolClass getLibraryCachesPath:DEF_USER_DATA];
    // 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    // 删除
    BOOL isDelete = [manager removeItemAtPath:deletePath error:nil];
    NSLog(@"删除  %d %@", isDelete,deletePath);
   
}
@end
