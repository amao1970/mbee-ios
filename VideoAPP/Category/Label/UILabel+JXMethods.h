//
//  UILabel+JXMethods.h
//  运营工具
//
//  Created by admso on 2017/3/15.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JXMethods)
-(void)setFrame:(CGRect)frame TextAlignment:(NSTextAlignment)textAlignment TextColor:(UIColor*)textColor Font:(NSInteger)font   NumberOfLines:(NSInteger)numberOfLines ;
-(void)setRedEnvelopeMoneyWithText:(NSString*)text  color:(UIColor*)color;
-(void)setRedEnvelopeDayWithAmount:(NSString*)amount  color:(UIColor*)color; 
// 首页/ 百分比
-(void)setHomePageProductPercentage:(NSString*)Num;
// 债权、转让价格
-(void)setTransferMoeny:(NSString*)Num;

// 字体 + 行间距
- (void)changeLineSpaceForText:(NSString *)text WithSpace:(float)space;

// 金额显示
-(NSString*)stringFromNumber:(NSString*)numberStr;

// 宽
-(void)jx_sizeThatFits:(float)width;
// 高
-(void)jx_heightThatFits:(float)height;


@end
