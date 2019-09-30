//
//  SVCUserInfoCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCUserInfoCell.h"

@implementation SVCUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img.layer.cornerRadius = self.img.height/2.f;
    self.img.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
