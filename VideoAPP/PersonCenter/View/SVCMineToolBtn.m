//
//  SVCMineToolBtn.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCMineToolBtn.h"

@implementation SVCMineToolBtn

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    };
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, CGRectGetHeight(contentRect) *0.6, CGRectGetWidth(contentRect), JXHeight(18));
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((CGRectGetWidth(contentRect)-JXWidth(30))/2.f, JXHeight(10), JXWidth(30), JXWidth(30));
}

@end
