//
//  SVCHomePageSearchBar.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageSearchBar.h"

@implementation SVCHomePageSmallSearchBar

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.layer.cornerRadius = 5;
    self.height = JXHeight(50);
    CGFloat imageWidth = self.type.imageView.bounds.size.width;
    CGFloat labelWidth = self.type.titleLabel.bounds.size.width;
    self.type.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.type.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
}

@end

@implementation SVCHomePageSearchBar

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.layer.cornerRadius = 6;
    self.height = JXHeight(50);
    CGFloat imageWidth = self.type.imageView.bounds.size.width;
    CGFloat labelWidth = self.type.titleLabel.bounds.size.width;
    self.type.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.type.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
}

-(void)setCanUserBar:(BOOL)CanUserBar
{
    self.search.userInteractionEnabled = CanUserBar;
    self.textFeild.userInteractionEnabled = CanUserBar;
    self.type.userInteractionEnabled = CanUserBar;
    self.bgView.userInteractionEnabled = YES;
}


@end

