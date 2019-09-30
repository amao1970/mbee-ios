//
//  NSString+Method.h
//  运营工具
//
//  Created admso on 2017/3/31.
//  Copyright © 2017年 台州绿湾信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Method)
-(BOOL)isChinese;

// 是否包含数字和英文
-(BOOL)checkIsHaveNumAndLetter;

// 判断是不是url
-(BOOL)isUrl;

// 金额
-(NSString*)jx_stringFromNumber;

-(NSString*)jx_getRightStr:(NSInteger)length;
-(NSString*)jx_getLeftStr:(NSInteger)length;
@end
