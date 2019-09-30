//
//  UILabel+JXMethods.m
//  运营工具
//
//  Created by admso on 2017/3/15.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import "UILabel+JXMethods.h"

@implementation UILabel (JXMethods)

-(void)jx_sizeThatFits:(float)width{
    self.width = [self sizeThatFits:self.size].width + width;
}

-(void)jx_heightThatFits:(float)height{
    self.height = [self sizeThatFits:self.size].height + height;
}


/** ---------------- 对外 api ------------------- */

/** 没有文本 */
-(void)setFrame:(CGRect)frame TextAlignment:(NSTextAlignment)textAlignment TextColor:(UIColor*)textColor Font:(NSInteger)font   NumberOfLines:(NSInteger)numberOfLines
{
    [self setFrame:frame Font:FontSize(font) TextColor:textColor TextAlignment:textAlignment text:nil NumberOfLines:numberOfLines];
}

- (void)changeLineSpaceForText:(NSString *)text WithSpace:(float)space {
    
    if(!text){
        text = @"";
    }
    NSString *labelText = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
//    [self sizeToFit];
    
}


/** ---------------- 私有api ------------------- */
-(void)setFrame:(CGRect)frame Font:(UIFont*)font TextColor:(UIColor*)textColor TextAlignment:(NSTextAlignment)textAlignment text:(NSString*)text NumberOfLines:(NSInteger)numberOfLines
{
    self.frame = frame;
    self.font = font;
    self.textColor = textColor;
    self.textAlignment = textAlignment;
    self.text = text;
    self.numberOfLines = numberOfLines;
}

// 我的红包 200
-(void)setRedEnvelopeMoneyWithText:(NSString*)text color:(UIColor*)color
{
    if(!text){
        text = @"";
    }
    NSString *str = [NSString stringWithFormat:@"¥ %@",text];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSFontAttributeName value:FontSize(15) range:NSMakeRange(0,1)];
    [attrString addAttribute:NSFontAttributeName value:FontSize(28) range:NSMakeRange(2, str.length-2)];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    self.attributedText = attrString;
}

// 我的红包模块  金额限制
-(void)setRedEnvelopeDayWithAmount:(NSString*)amount color:(UIColor*)color
{
    
}

// 首页、百分比
-(void)setHomePageProductPercentage:(NSString*)Num
{
    
}

// 债权、转让价格
-(void)setTransferMoeny:(NSString*)Num
{
    
}

-(NSString*)stringFromNumber:(NSString*)numberStr{
    return [self stringFromNumber:[NSNumber numberWithDouble:[numberStr doubleValue]] numberFormatter:nil];
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

@end
