//
//  SVCMidCollectionViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCMidCollectionViewCell.h"



@implementation SVCMidCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.plusLabel.layer.cornerRadius = 3.0f;
    self.plusLabel.layer.masksToBounds = YES;
}

@end
