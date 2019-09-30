//
//  UIButton+JXMethods.m
//  运营工具
//
//  Created admso on 2017/3/20.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import "UIButton+JXMethods.h"
 #import "SDWebImage/UIButton+WebCache.h"

@implementation UIButton (JXMethods)

-(void)jx_setImageWithUrlString:(NSString*)image
{
    NSURL *url = [NSURL URLWithString:image];
    UIImage *phImg = [UIImage imageNamed:@"默认图"];
    [self sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:phImg];
}

-(void)jx_setBackgroundImageWithUrlString:(NSString*)image
{
    NSURL *url = [NSURL URLWithString:image];
    UIImage *phImg = [UIImage imageNamed:@"默认图"];
    [self sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:phImg];
}

-(void)jx_setImageWithimgName:(NSString*)image
{
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

-(void)jx_setHighlightedWithColor:(UIColor*)color{
    [self setBackgroundImage:[self createImageWithColor:color] forState:UIControlStateHighlighted];
}

-(void)jx_setNormalWithColor:(UIColor*)color{
    [self setBackgroundImage:[self createImageWithColor:color] forState:UIControlStateNormal];
}

-(void)jx_setSelectedWithColor:(UIColor*)color{
    [self setBackgroundImage:[self createImageWithColor:color] forState:UIControlStateSelected];
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
