//
//  VDUserCenterCell.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDUserCenterCell.h"

@implementation VDUserCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.height = [self.titleLab sizeThatFits:self.titleLab.size].height;
    if (self.titleLab.height > JXHeight(67)) {
        self.titleLab.height = JXHeight(67);
    }
}

@end
