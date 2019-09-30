//
//  VDUploadVideoCell.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDUploadVideoCell.h"

@implementation VDUploadVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.descLab.height = [self.descLab sizeThatFits:self.descLab.size].height;
    if (self.descLab.height > JXHeight(67)) {
        self.descLab.height = JXHeight(67);
    }
}

@end
