//
//  JXPlayBackCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXPlayBackCell.h"

@implementation JXPlayBackCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.img.layer.cornerRadius = self.img.height/2.f;
    self.img.clipsToBounds = YES;
    self.but.userInteractionEnabled = NO;
    self.but.layer.cornerRadius = 5;
    self.line.height = 0.5;
    self.line.y = self.height - 0.5;
    self.line.backgroundColor = [UIColor hexStringToColor:@"e5e5e5"];
    if (!self.subtitleLab.text.length) {
        NSInteger lookNum = arc4random() % 190;
        lookNum+=10;
        self.subtitleLab.text = [NSString stringWithFormat:@"粉丝数：%ld万",lookNum];
    }
    
    self.titleLab.height = [self.titleLab sizeThatFits:self.titleLab.size].height+8;
    self.titleLab.y = self.subtitleLab.y - self.titleLab.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLab.numberOfLines = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
