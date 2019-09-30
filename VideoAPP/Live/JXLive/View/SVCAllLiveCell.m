//
//  SVCAllLiveCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCAllLiveCell.h"

@implementation SVCAllLiveCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.img.contentMode = UIViewContentModeScaleAspectFill;
    self.img.clipsToBounds = YES;
    self.title.numberOfLines = 0;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.img.height = self.height;
    self.imgMaskView.height = self.height;
    self.title.centerY = self.height - JXHeight(30);
    self.subtitle.centerY = self.height - JXHeight(12);
    self.icon.centerY = self.height - JXHeight(12);
    
    if (!self.subtitle.text.length) {
        NSInteger lookNum = arc4random() % 49000;
        lookNum+=1000;
        self.subtitle.text = [NSString stringWithFormat:@"观众：%ld人",lookNum];
    }
    
    self.title.height = [self.title sizeThatFits:self.title.size].height;
    self.title.y = self.subtitle.y - self.title.height;
}

@end
