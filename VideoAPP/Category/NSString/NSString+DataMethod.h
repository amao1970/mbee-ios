//
//  NSString+DataMethod.h
//  运营工具
//
//  Created admso on 2017/4/19.
//  Copyright © 2017年 台州绿湾信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, dateType) {
    dateTypeNone = 0, // 无日期
    dateTypeDot  // . | 2017.04.05
};

typedef NS_ENUM(NSInteger, timeType) {
    timeTypeNone = 0,  // 无时间
    timeTypeColon , // : | 10:47:24
};

@interface NSString (DataMethod)

// 年月日 时分秒 | 常用 | 日期和时间 2017.03.16 10:47:24
-(NSString*)setUpOftenUseType;
// 年月日
-(NSString*)setUpDate;
// 年月日 type
-(NSString*)setUpDateType:(NSString*)typeS;
// 时分秒
-(NSString*)setUpTime;


// 2017.03.16 10:47:24
-(NSString*)setUpDateWithDatetype:(dateType)datetype timetype:(timeType)timetype type:(NSString*)type;

//-(NSString *)timeWithTimeIntervalString:(NSString *)timeString;

-(NSString*)remainingDays;
@end
