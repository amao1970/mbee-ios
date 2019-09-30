//
//  UIColor+MSExtension.h
//  One Pound
//
//  Created by dianmiaoshou on 16/3/15.
//  Copyright © 2016年 dianmiaoshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MSExtension)
/** 生成随机色*/
+(UIColor *)randomColor;
/** 根据16进制的字符串生成相应的颜色,默认透明度为1.0*/
+(UIColor *)colorWithHex:(NSString *)hexColor;
/** 根据16进制的字符串和传入的alpha生成相应的颜色*/
+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha;
@end
