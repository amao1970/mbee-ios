//
//  UIImageView+JXMethod.m
//  运营工具
//
//  Created by admso on 2017/3/15.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import "UIImageView+JXMethod.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation UIImageView (JXMethod)

-(void)jx_setImageWithUrl:(NSString*)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage: [UIImage imageNamed:@"默认图"] ];
}

- (UIImage*)drawRect
{
    //画圆，以便以后指定可以显示图片的范围
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, self.frame);
    
    //指定上下文中可以显示内容的范围就是圆的范围
    CGContextClip(ctx);
    UIImage *image2=[UIImage imageNamed:@"默认图"];
    [image2 drawAtPoint:CGPointMake(100, 100)];
    return image2;
}

-(void)jx_setImageWithImageName:(NSString*)imgName
{
    if (!imgName.length) {
        [self setImage:[UIImage imageNamed:imgName]];
    }
    if (imgName==nil) {
        [self setImage:[UIImage imageNamed:imgName]];
    }
    [self setImage:[UIImage imageNamed:imgName]];
}


-(void)jx_setHeadImgWithUrl:(NSString*)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

-(void)jx_setCornerRadius:(float)cornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(void)jx_setUpCornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.height/2.f;
}



@end
