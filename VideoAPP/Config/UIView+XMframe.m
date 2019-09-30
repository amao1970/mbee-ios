//
//  UIView+XMframe.m
//  baisi-one
//
//  Created by montnets on 16/8/31.
//  Copyright © 2016年 montnets. All rights reserved.
//  -----------------所有UI控件的frame----------------

#import "UIView+XMframe.h"

@implementation UIView (XMframe)

-(void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(CGFloat)width{
    return self.frame.size.width;
}


-(void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setX:(CGFloat)X{
    CGRect frame=self.frame;
    frame.origin.x=X;
    self.frame=frame;
}

-(CGFloat)X{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)Y{
    CGRect frame=self.frame;
    frame.origin.y=Y;
    self.frame=frame;
}

-(CGFloat)Y{
    return self.frame.origin.y;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint cenetr=self.center;
    cenetr.x=centerX;
    self.center=cenetr;
}
-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint cenetr=self.center;
    cenetr.y=centerY;
    self.center=cenetr;
}

-(CGFloat)centerY{
    return self.center.y;
}


-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}

-(CGSize)size{
    return self.frame.size;
}

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}



@end
