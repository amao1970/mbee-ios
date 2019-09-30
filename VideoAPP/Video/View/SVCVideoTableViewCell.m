//
//  SVCVideoTableViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/11/22.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCVideoTableViewCell.h"
#import "SVCVideoDetailModel.h"
#import "SVCHomePageModel.h"

@implementation SVCVideoTableViewCell

-(float)setUpMovieModel:(SVCMoviePlayerModel*)model{
    self.score.hidden = NO;
    self.name.hidden = NO;
    self.score.text = model.score;
    self.score.width = [self.score sizeThatFits:self.score.size].width+13;
    self.name.text = model.name;
    self.name.width = [self.name sizeThatFits:self.name.size].width+13;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.title.text = model.title;
    self.title.height = [self.title sizeThatFits:self.title.size].height+20;
    self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname,model.createtime];
    self.attributeLab.text = model.attribute;
    self.attributeLab.hidden = !model.attribute.length;
    self.attributeLab.width = [self.attributeLab sizeThatFits:self.attributeLab.size].width+13;
//    self.attributeLab.x = SCR_WIDTH - self.attributeLab.width - JXWidth(10);
    return (self.title.height+self.img.height+self.subtitleLab.height+15);
}

-(float)setUpVideoModel:(SVCVideoDetailModel*)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.title.text = model.title;
    self.title.height = [self.title sizeThatFits:self.title.size].height+20;
    self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname,model.createtime];
    self.attributeLab.text = model.attribute;
    self.attributeLab.hidden = !model.attribute.length;
    self.attributeLab.width = [self.attributeLab sizeThatFits:self.attributeLab.size].width+13;
//    self.attributeLab.x = SCR_WIDTH - self.attributeLab.width - JXWidth(25);
    return (self.title.height+self.img.height+self.subtitleLab.height+15);
}

-(float)setUpHomePageModel:(SVCHomePageModel*)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.title.text = model.title;
    self.title.height = [self.title sizeThatFits:self.title.size].height+20;
    self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname,model.createtime];
    self.attributeLab.text = model.attribute;
    self.attributeLab.hidden = !model.attribute.length;
    self.attributeLab.width = [self.attributeLab sizeThatFits:self.attributeLab.size].width+13;
//    self.attributeLab.x = SCR_WIDTH - self.attributeLab.width - JXWidth(25);
    return (self.title.height+self.img.height+self.subtitleLab.height+15);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.img.y = self.title.bottom;
    self.maskView.centerY = self.img.centerY;
    self.icon.centerY = self.img.centerY;
    self.subtitleLab.y = self.img.bottom;
    self.attributeLab.y = self.img.y;
    self.attributeLab.x = SCR_WIDTH - self.attributeLab.width - JXWidth(10);
    self.score.y = self.img.bottom - JXWidth(5) - self.score.height;
    self.name.y = self.attributeLab.y;
    if (!self.attributeLab.isHidden) {
        self.name.x = self.attributeLab.x - self.name.width - JXWidth(10);
        
        // 左上和右上为圆角
//        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.attributeLab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
//        cornerRadiusLayer.frame = self.attributeLab.bounds;
//        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
//        self.attributeLab.layer.mask = cornerRadiusLayer;
    }else{
        self.name.x = SCR_WIDTH - self.name.width - JXWidth(10);
    }
    if (!self.name.isHidden) {
        // 左上和右上为圆角
//        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.name.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
//        cornerRadiusLayer.frame = self.name.bounds;
//        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
//        self.name.layer.mask = cornerRadiusLayer;
    }
//    else{
//        self.attributeLab.x = SCR_WIDTH - self.attributeLab.width - JXWidth(25);
//    }
    
}

@end
