//
//  ToolClass.h
//  Xuebei
//
//  Created by maceasy on 15/11/27.
//  Copyright © 2015年 macHY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject


//检测是否是手机号码
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)isPhone:(NSString *)phoneNum;
//设置loading的样式
+(void)mSettingUIActivityViewStatus:(UIActivityIndicatorView *)activity;
//获取
+(NSString *)getLibraryCachesPath:(NSString *)fileName;
+(BOOL)mIsIphone4Or4s;
+(BOOL)mIsIphone5;
+(BOOL)mIsIphone6;
+(BOOL)mIsIphone6plus;

//计算一个label的大小
+(CGSize)mCalculateVerticalSize:(NSString *)labelText postLabelMaxWidth:(CGFloat)postLabelMaxWidth font:(UIFont*)font defaultSpace:(CGFloat)space ;



@end
