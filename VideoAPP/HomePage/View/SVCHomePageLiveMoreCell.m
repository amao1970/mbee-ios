//
//  SVCHomePageLiveMoreCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageLiveMoreCell.h"

@implementation SVCHomePageLiveMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.img.layer.cornerRadius = self.img.height/2.f;
    self.img.clipsToBounds = YES;
}

@end
