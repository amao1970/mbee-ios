//
//  UILabel+FlickerNumber.h
//  FlickerNumber
//
//  Created by Diaoshu on 15-2-1.
//  Copyright (c) 2015年 DDKit. All rights reserved.
//


//if([(UISwitch *)sender isOn]){
//    if([self.title isEqualToString:@"Flicker An Integer Number"]){
//        [self.lblFlicker dd_setNumber:@(1234567) formatter:nil];
//    }else if([self.title isEqualToString:@"Flicker A Float Number"]){
//        [self.lblFlicker dd_setNumber:@(12345.789) formatter:nil];
//    }else if([self.title isEqualToString:@"Flicker A Format Number"]){
//        [self.lblFlicker dd_setNumber:@(6882.238) format:@"￥%@" formatter:nil];
//    }else if([self.title isEqualToString:@"Flicker An Attribute Number"]){
//        id attributes = [NSDictionary dictionaryWithAttribute:@{NSForegroundColorAttributeName:[UIColor redColor]}
//                                                     andRange:NSMakeRange(0, 1)];
//        [self.lblFlicker dd_setNumber:@(1888.88) formatter:nil attributes:attributes];
//    }else{
//        id attributes = @[[NSDictionary dictionaryWithAttribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}
//                                                       andRange:NSMakeRange(0, 1)],
//                          [NSDictionary dictionaryWithAttribute:@{NSForegroundColorAttributeName:[UIColor redColor]}
//                                                       andRange:NSMakeRange(1, 3)]];
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
//        formatter.numberStyle = NSNumberFormatterDecimalStyle;
//        [self.lblFlicker dd_setNumber:@(1234.567) duration:1.0f format:@"￥%@" numberFormatter:formatter attributes:attributes];
//    }
//}else{
//    if([self.title isEqualToString:@"Flicker An Integer Number"]){
//        [self.lblFlicker dd_setNumber:@(1234567)];
//    }else if([self.title isEqualToString:@"Flicker A Float Number"]){
//        [self.lblFlicker dd_setNumber:@(12345.789)];
//    }else if([self.title isEqualToString:@"Flicker A Format Number"]){
//        [self.lblFlicker dd_setNumber:@(6882.238) format:@"￥%.3f"];
//    }else if([self.title isEqualToString:@"Flicker An Attribute Number"]){
//        id attributes = [NSDictionary dictionaryWithAttribute:@{NSForegroundColorAttributeName:[UIColor redColor]}
//                                                     andRange:NSMakeRange(0, 1)];
//        [self.lblFlicker dd_setNumber:@(1888.88) attributes:attributes];
//    }else{
//        id attributes = @[[NSDictionary dictionaryWithAttribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}
//                                                       andRange:NSMakeRange(0, 1)],
//                          [NSDictionary dictionaryWithAttribute:@{NSForegroundColorAttributeName:[UIColor redColor]}
//                                                       andRange:NSMakeRange(1, 3)]];
//        [self.lblFlicker dd_setNumber:@(1234.567) duration:1.0f format:@"￥%.2f" attributes:attributes];
//    }
//}

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Format,
    Mutiable
} FlickerNumberAttributeType;

@interface UILabel (FlickerNumber)

/**
 *  flicker number only a number variable
 *
 *  @param number flicker number
 */
- (void)dd_setNumber:(NSNumber *)number;

/**
 *  flicker number with numberformatter style
 *
 *  @param number    flicker number
 *  @param formatter formatter style
 */
- (void)dd_setNumber:(NSNumber *)number
           formatter:(NSNumberFormatter *)formatter;

/**
 *  flicker number in duration
 *
 *  @param number   flicker number
 *  @param duration duration time
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration;

/**
 *  flicker number in duartion with numberformatter style
 *
 *  @param number   flicker number
 *  @param duration duration time
 *  @param formatter formatter style
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
           formatter:(NSNumberFormatter *)formatter;

/**
 *  flicker number with format
 *
 *  @param number    flicker number
 *  @param formatStr format string
 */
- (void)dd_setNumber:(NSNumber *)number
              format:(NSString *)formatStr;

/**
 *  flicker number with numberformatter style & format string
 *
 *  @param number    flicker number
 *  @param formatStr format string
 *  @param formatter formatter style
 */
- (void)dd_setNumber:(NSNumber *)number
              format:(NSString *)formatStr
           formatter:(NSNumberFormatter *)formatter;


/**
 *  flicker number with attributes
 *
 *  @param number flicker number
 *  @param attrs  text attributes
 */
- (void)dd_setNumber:(NSNumber *)number
          attributes:(id)attrs;

/**
 *  flicker number with attributes & formatter style
 *
 *  @param number    flicker number
 *  @param formatter formatter style
 *  @param attrs     text attributes
 */
- (void)dd_setNumber:(NSNumber *)number
           formatter:(NSNumberFormatter *)formatter
          attributes:(id)attrs;

/**
 *  flicker number with format in duration
 *
 *  @param number    flicker number
 *  @param duration  duration time
 *  @param formatStr format string
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
              format:(NSString *)formatStr;

/**
 *  flicker number with format string & formatter style in duration
 *
 *  @param number    flicker number
 *  @param duration  duration time
 *  @param formatStr format string
 *  @param formatter formatter style
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
              format:(NSString *)formatStr
           formatter:(NSNumberFormatter *)formatter;
/**
 *  flicker number with attribute in duration
 *
 *  @param number   flicker number
 *  @param duration duration time
 *  @param attrs    text attributes
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
          attributes:(id)attrs;

/**
 *  flicker number with attribute & formatter style in duration
 *
 *  @param number    flicker number
 *  @param duration  duration time
 *  @param formatter formatter style
 *  @param attrs     text attributes
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
           formatter:(NSNumberFormatter *)formatter
          attributes:(id)attrs;

/**
 *  flicker number method
 *
 *  @param number   flicker number
 *  @param duration duration time
 *  @ param format   format string
 *  @ param attrs    text attribute
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
              format:(NSString *)formatStr
          attributes:(id)attrs;

/**
 *  flicker number method
 *
 *  @param number    flicker number
 *  @param duration  duration time
 *  @param formatStr format string
 *  @param formatter number formatter
 *  @param attrs     text attribute
 */
- (void)dd_setNumber:(NSNumber *)number
            duration:(NSTimeInterval)duration
              format:(NSString *)formatStr
     numberFormatter:(NSNumberFormatter *)formatter
          attributes:(id)attrs;

@end

@interface NSDictionary(FlickerNumber)

+ (instancetype)dictionaryWithAttribute:(NSDictionary *)attribute andRange:(NSRange)range;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
