//
//  SVCunderLineTF.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/8.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCunderLineTF.h"

@implementation SVCunderLineTF


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor hexStringToColor:@"eeeeee"].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame ) - 1, CGRectGetWidth(self.frame), 1));
}


@end
