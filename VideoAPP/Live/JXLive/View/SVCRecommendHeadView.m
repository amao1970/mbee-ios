//
//  SVCRecommendHeadView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCRecommendHeadView.h"

@implementation SVCRecommendHeadView

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.width = [self.titleLab sizeThatFits:self.titleLab.size].width+10;
    self.subtitleLab.layer.cornerRadius = 5.f;
    self.subtitleLab.clipsToBounds = YES;
    self.subtitleLab.x = self.titleLab.right + 5;
    
}

@end
