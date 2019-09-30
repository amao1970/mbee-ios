//
//  ToolClass.m
//  Xuebei
//
//  Created by maceasy on 15/11/27.
//  Copyright © 2015年 macHY. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass


//检测是否是手机号码
+(BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189  ^[1][3|4|5|7|8][0-9]{9}$
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";@"^[1][3|4|5|7|8][0-9]{9}$"原本
     NSString * MOBILE = @"^1+[3578]+\\d{9}";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
  NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        if ([self isPhone:mobileNum]) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
            {
                return YES;
            }
            else
            {
                    return NO;
            }
}

//额外加个17开头的  14开头的，新出的手机号码
+(BOOL)isPhone:(NSString *)phoneNum{
    if (phoneNum.length == 11) {
        phoneNum = [phoneNum substringToIndex:2];//截取下标2之前的字符串
        if ([phoneNum isEqualToString:@"14"] || [phoneNum isEqualToString:@"17"]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    
}

//设置loading的样式
+(void)mSettingUIActivityViewStatus:(UIActivityIndicatorView *)activity{
    activity.hidden = YES;
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    // 圆角
    activity.layer.masksToBounds = YES;
    activity.layer.cornerRadius = 6.0;
}

//获取路径
+(NSString *)getLibraryCachesPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:fileName];
}


//是否是iphone4 iphone4s
+(BOOL)mIsIphone4Or4s{
    
    CGSize  rect = [UIScreen mainScreen].bounds.size;
    if (rect.width == 320 && rect.height == 480) {
        return YES;
    }
    return NO;
}

+(BOOL)mIsIphone5{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return (bounds.size.height * scale == 1136.0 && bounds.size.width * scale == 640.0) ? YES :NO;
}
//iPhone 6 则采用了1334×750分辨率的屏幕，PPI值为326。
+(BOOL)mIsIphone6{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return (bounds.size.height * scale == 1334.0 && bounds.size.width * scale == 750.0) ? YES :NO;
}
//iPhone 6 Plus 采用标准的 1920×1080分辨率屏幕，PPI值为414
+(BOOL)mIsIphone6plus{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return (bounds.size.height*scale == 2208.0 && bounds.size.width*scale == 1242.0) ? YES :NO;
}

//计算一个label的大小
+(CGSize)mCalculateVerticalSize:(NSString *)labelText postLabelMaxWidth:(CGFloat)postLabelMaxWidth font:(UIFont*)font defaultSpace:(CGFloat)space{
    
    //UIFont *font = [UIFont fontWithName:@"NotoSansHans-DemiLight" size:FONT_SIZE];
    NSDictionary *cellTextDic=nil;
    if (space!=0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:space];
        cellTextDic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    }else{
        cellTextDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    }
    
    
    //根据控件的大小和控件之间的距离，和手机屏幕的宽度，动态计算label的最长长度
    //int postLabelMaxWidth = [UIScreen mainScreen].bounds.size.width - 2*16;  //16是距离左右边框的距离
    CGSize labelSize = [labelText boundingRectWithSize:CGSizeMake(postLabelMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:cellTextDic context:nil].size;
    return  CGSizeMake(ceil(labelSize.width), ceil(labelSize.height));// labelSize;

}

@end


