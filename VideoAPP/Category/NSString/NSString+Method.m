//
//  NSString+Method.m
//  运营工具
//
//  Created admso on 2017/3/31.
//  Copyright © 2017年 台州绿湾信息技术有限公司. All rights reserved.
//

#import "NSString+Method.h"

@implementation NSString (Method)

-(NSString*)jx_getLeftStr:(NSInteger)length{
    return [self substringWithRange:NSMakeRange(0, length)];
}

-(NSString*)jx_getRightStr:(NSInteger)length{
    return [self substringWithRange:NSMakeRange(self.length - length,length)];
}

-(NSString*)jx_stringFromNumber{
    
    return [self stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]] numberFormatter:nil];
}


- (NSString *)stringFromNumber:(NSNumber *)number numberFormatter:(NSNumberFormatter *)formattor{
    if(!formattor){
        formattor = [[NSNumberFormatter alloc] init];
        formattor.formatterBehavior = NSNumberFormatterBehavior10_4;
        formattor.numberStyle = NSNumberFormatterDecimalStyle;
        formattor.maximumFractionDigits = 2;
        formattor.minimumFractionDigits = 2;
    }
    return [formattor stringFromNumber:number];
}

-(BOOL)isChinese
{
    if (!self.length) {
        return NO;
    }
    
    
    NSRange range = NSMakeRange(0, 1);
    NSString *subString = [self substringWithRange:range];
    const char    *cString = [subString UTF8String];
    if (strlen(cString) == 3)
    {
        NSLog(@"汉字:%s", cString);
        return YES;
    }
    
//    int a = [str characterAtIndex:0];
//    if( a > 0x4e00 && a < 0x9fff)
//    {
//        return YES;
//    }
    return NO;
}

//直接调用这个方法就行
-(BOOL)checkIsHaveNumAndLetter{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, self.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    if (tNumMatchCount == 0) {
        //全部符合数字，表示沒有英文
        return NO;
    } else if (tLetterMatchCount == 0) {
        //全部符合英文，表示沒有数字
        return NO;
    } else{
        return YES;
    }
    
//    else if (tNumMatchCount + tLetterMatchCount == password.length) {
//        //符合英文和符合数字条件的相加等于密码长度
//        return 3;
//    } else {
//        return 4;
//        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
//    }
    
}

-(BOOL)isUrl{
    
    BOOL isHttp =    [self containsString:@"http://"];
    BOOL isHttps =    [self containsString:@"https://"]; // http(s)?://[^\\s]+
    return (isHttp || isHttps);
}


@end
