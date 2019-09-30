//
//  NSString+DataMethod.m
//  运营工具
//
//  Created admso on 2017/4/19.
//  Copyright © 2017年 台州绿湾信息技术有限公司. All rights reserved.
//

#import "NSString+DataMethod.h"

@implementation NSString (DataMethod)

// ----------------  剩余天数  -------------------
#pragma mark -- 剩余天数

// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//设置时区,这个对于时间的处理有时很重要
//例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
//例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
//他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
-(NSString*)remainingDays{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[dateFormatter dateFromString:[self setUpDateWithDatetype:dateTypeDot timetype:timeTypeColon type:@"-"]]];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return [NSString stringWithFormat:@"%ld",(long)dayComponents.day];
}

// ----------------  返回格式数据  -------------------
// 2017.03.16 10:47:24
-(NSString*)setUpOftenUseType{
    return [self setUpDateWithDatetype:dateTypeDot timetype:timeTypeColon type:@"."];
}

// 年月日
-(NSString*)setUpDate{
    return [self setUpDateWithDatetype:dateTypeDot timetype:timeTypeNone type:@"."];
}

// 年月日 type
-(NSString*)setUpDateType:(NSString*)typeS{
    return [self setUpDateWithDatetype:dateTypeDot timetype:timeTypeNone type:typeS];
}

// 时分秒
-(NSString*)setUpTime{
    return [self setUpDateWithDatetype:dateTypeNone timetype:timeTypeColon type:@"."];
}


// 接口封装
-(NSString*)setUpDateWithDatetype:(dateType)datetype timetype:(timeType)timetype type:(NSString*)type
{
    // 年月日
    NSString *yearStr  = [self getYear];
    NSString *monthStr = [self getMonth];
    NSString *dayStr   = [self getDay];
    // 时分秒
    NSString *hoursStr = [self getHours];
    NSString *minStr   = [self getMinutes];
    NSString *secStr   = [self getSeconds];
    
    // 年月日
    NSString *dateStr = @"";
    if (datetype == dateTypeDot){
        dateStr = [NSString stringWithFormat:@"%@%@%@%@%@",yearStr,type,monthStr,type,dayStr];
    }
    
    // 时分秒
    NSString *timeStr = @"";
    if (timetype == timeTypeColon) {
        timeStr = [NSString stringWithFormat:@"%@:%@:%@",hoursStr,minStr,secStr];
    }
    
    // 判断时期和时间是否都有
    if (datetype != dateTypeNone  && timetype != timeTypeNone) {
        return [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    }
    else if (datetype != dateTypeNone) {
        return dateStr;
    }
    else{
        return timeStr;
    }
}

// ----------------  单个数据  -------------------

// 获取秒
-(NSString*)getSeconds
{
    if (self.length<14) {
        return @"00";
    }
    return [self substringWithRange:NSMakeRange(12, 2)];
}

// 获取分
-(NSString*)getMinutes
{
    if (self.length<12) {
        return @"00";
    }
    return [self substringWithRange:NSMakeRange(10, 2)];
}

// 获取时
-(NSString*)getHours
{
    if (self.length<10) {
        return @"00";
    }
    return [self substringWithRange:NSMakeRange(8, 2)];
}

// 获取日
-(NSString*)getDay
{
    if (self.length<8) {
        return @"00";
    }
    return [self substringWithRange:NSMakeRange(6, 2)];
}

// 获取月
-(NSString*)getMonth
{
    if (self.length<6) {
        return @"00";
    }
    return [self substringWithRange:NSMakeRange(4, 2)];
}

// 获取年
-(NSString*)getYear
{
    if (self.length<4) {
        return @"0000";
    }
    return [self substringWithRange:NSMakeRange(0, 4)];
}

@end
