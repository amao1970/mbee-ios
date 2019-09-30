//
//  SVCLiveToolBtn.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCLiveToolBtn.h"

@implementation SVCLiveToolBtn

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        if (IsIphone5a5c5s) {
            self.titleLabel.font = [UIFont systemFontOfSize:10];
        }
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        if (IsIphone5a5c5s) {
            self.titleLabel.font = [UIFont systemFontOfSize:10];
        }
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, CGRectGetHeight(contentRect)-20, CGRectGetWidth(contentRect), 20);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (IsIphone5a5c5s) {
        return CGRectMake( (CGRectGetWidth(contentRect)-JXWidth(25))/2.f, 5, JXWidth(20), JXWidth(20));;
    }
    return CGRectMake( (CGRectGetWidth(contentRect)-23)/2.f, 6, JXWidth(20), JXWidth(20));;
}

@end
