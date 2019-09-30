//
//  SVCliveViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/16.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCliveViewCell.h"
#import "UIView+XMframe.h"

@implementation SVCliveViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.contentView.backgroundColor = [UIColor redColor];
    self.numButton.layer.cornerRadius = 6.50f;
    self.numButton.layer.masksToBounds = YES;
    
//    self.imageViewICon.image = [UIImage imageNamed:@""];
//    NSString *imaurl = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3453967528,1641185267&fm=27&gp=0.jpg";
//    [self.imageViewICon sd_setImageWithURL:[NSURL URLWithString:imaurl] placeholderImage:nil];
    self.imageViewICon.layer.cornerRadius = self.imageViewICon.width/2.0f;
    self.imageViewICon.layer.masksToBounds = YES;
//    self.numButton.hidden = YES;
    
    
}

@end
