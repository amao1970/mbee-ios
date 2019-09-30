//
//  SVCLiveCollectionViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by chen on 2018/6/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLiveCollectionViewCell.h"
#import "UIView+XMframe.h"
#import "SVCIndeModel.h"
#import "SVCLiveModel.h"
#import "BKNetworkHelper.h"


@interface SVCLiveCollectionViewCell()


@end

@implementation SVCLiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageViewIcon.layer.cornerRadius = self.imageViewIcon.width/2.0;
    self.imageViewIcon.layer.masksToBounds = YES;
//    self.imageViewIcon.backgroundColor = [UIColor redColor];
    
    self.LiveNumLabel.layer.cornerRadius = 7.0f;
    self.LiveNumLabel.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = Color(245, 245, 245).CGColor;
    self.contentView.layer.borderWidth = 0.8;
    
    
}
-(void)setIndexModel:(SVCIndeModel *)indexModel{
    _indexModel = indexModel;
    self.nikeLabel.text = indexModel.name;
    [self.imageViewIcon sd_setImageWithURL:[NSURL URLWithString:indexModel.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
}

-(void)setLiveModel:(SVCLiveModel *)LiveModel{
    _LiveModel = LiveModel;
    self.nikeLabel.text = LiveModel.title;
    [self.imageViewIcon sd_setImageWithURL:[NSURL URLWithString:LiveModel.img] placeholderImage:[UIImage imageNamed:@"默认图"]];
    [self.LiveNumLabel setTitle:[NSString stringWithFormat:@"%@",LiveModel.number] forState:0];
    if ([[NSString stringWithFormat:@"%@",LiveModel.is_badge] isEqualToString:@"1"]) {
        self.danmuButton.hidden = NO;
    }else{
        self.danmuButton.hidden = YES;
    }
}


@end
