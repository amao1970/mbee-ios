//
//  UIView+JX.m
//  TradeCoin
//
//  Created by admxjx on 2018/8/17.
//  Copyright © 2018年 lili lili. All rights reserved.
//

#import "UIView+JX.h"

#define spaceWidth 15
#define LineWidth  .7

@implementation UIView (JX)

static NSString *LineKey = @"LineKey";

+(instancetype)getViewFormNSBunld
{
    Class controllerClass = [self class];
    
    return [[NSBundle mainBundle] loadNibNamed:
            NSStringFromClass(controllerClass) owner:nil options:nil ].lastObject;
}

-(void)setLine:(UIView *)line
{
    objc_setAssociatedObject(self, &LineKey, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)line
{
    return objc_getAssociatedObject(self, &LineKey);
}



-(void)updateUI
{
    for (UIView *temp in self.subviews) {
        temp.frame = JXRectMake(temp.x, temp.y, temp.width, temp.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = JXRectMake(temp1.x, temp1.y, temp1.width, temp1.height);
        }
    }
}

-(void)addLineWith:(UIViewLineStyle)lineStyle
{
    if(!self.line)
    {
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = [UIColor hexStringToColor:@"e5e5e5"];
        [self addSubview:self.line];
    }
    
    if(lineStyle == UIViewLineStyleLeftSpace)
    {   self.line.tag = lineStyle;
        self.line.frame = CGRectMake(spaceWidth, self.height -  LineWidth, self.width - spaceWidth, LineWidth);
        
    }else if (lineStyle == UIViewLineStyleRightSpace)
    {
        self.line.tag = lineStyle;
        self.line.frame = CGRectMake(0, self.height - LineWidth, self.width - spaceWidth, LineWidth);
    }else if (lineStyle == UIViewLineStyleLeftAndRightSpace)
    {
        self.line.tag = lineStyle;
        self.line.frame = CGRectMake(spaceWidth, self.height - LineWidth, self.width - spaceWidth*2, LineWidth);
    }else if (lineStyle == UIViewLineStyleNoneSpace)
    {
        self.line.tag = lineStyle;
        self.line.frame = CGRectMake(0, self.height - LineWidth, self.width, LineWidth);
    }
}

////修改CGRectMake
//CG_INLINE CGRect
//JXRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//{
//    float autoSizeScaleX;
//    float autoSizeScaleY;
//    if(SCR_WIDTH != 375){
//        autoSizeScaleX = SCR_WIDTH/375.f;
//        autoSizeScaleY = SCR_HIGHT/667.f;
//    }else{
//        autoSizeScaleX = 1.0;
//        autoSizeScaleY = 1.0;
//    }
//    if (SCR_HIGHT == 812) {
//        autoSizeScaleY = SCR_HIGHT/812.f;
//    }
//    
//    CGRect rect;
//    rect.origin.x = x * autoSizeScaleX;
//    rect.origin.y = y * autoSizeScaleY;
//    rect.size.width = width * autoSizeScaleX;
//    rect.size.height = height * autoSizeScaleY;
//    return rect;
//}

@end
