//
//  SVCHomePageImgCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/6.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageImgCell.h"


@implementation SVCHomePageImgOfTypeNoImgCell

-(void)updateHomePageWithMode:(SVCHomePageModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
}

-(void)updateNovelWithMode:(SVCNovelModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
}

@end

@implementation SVCHomePageImgOfTypeOneImgCell

-(void)updateHomePageWithMode:(SVCHomePageModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"默认图"]];
}

-(void)updateImageWithMode:(SVCImageDetailModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
}

-(void)updateNovelWithMode:(SVCNovelModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"默认图"]];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.img.contentMode = UIViewContentModeScaleAspectFill;
    self.img.clipsToBounds = YES;
}

@end

@implementation SVCHomePageImgCell

-(void)updateHomePageWithMode:(SVCHomePageModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
    NSArray *imgUrlAry = [model.imgurl componentsSeparatedByString:@"|"];
    for (NSInteger i = 0 ; i < imgUrlAry.count; i++ ) {
        [self.imgAry[i] sd_setImageWithURL:[NSURL URLWithString:imgUrlAry[i]]placeholderImage:[UIImage imageNamed:@"默认图"]];
        ((UIImageView*)self.imgAry[i]).contentMode = UIViewContentModeScaleAspectFill;
        ((UIImageView*)self.imgAry[i]).clipsToBounds = YES;
    }
}

-(void)updateImageWithMode:(SVCImageDetailModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
    NSArray *imgUrlAry = [model.image componentsSeparatedByString:@"|"];
    for (NSInteger i = 0 ; i < imgUrlAry.count; i++ ) {
        [self.imgAry[i] sd_setImageWithURL:[NSURL URLWithString:imgUrlAry[i]]placeholderImage:[UIImage imageNamed:@"默认图"]];
        ((UIImageView*)self.imgAry[i]).contentMode = UIViewContentModeScaleAspectFill;
        ((UIImageView*)self.imgAry[i]).clipsToBounds = YES;
    }
}

-(void)updateNovelWithMode:(SVCNovelModel*)model
{
    self.titleLab.text = model.title;
    if (model.nickname.length) {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@  %@",model.nickname, model.createtime];;
    } else {
        self.subtitleLab.text = [NSString stringWithFormat:@"%@", model.createtime];;
    }
    
    NSArray *imgUrlAry = [model.image componentsSeparatedByString:@"|"];
    for (NSInteger i = 0 ; i < imgUrlAry.count; i++ ) {
        [self.imgAry[i] sd_setImageWithURL:[NSURL URLWithString:imgUrlAry[i]]placeholderImage:[UIImage imageNamed:@"默认图"]];
        ((UIImageView*)self.imgAry[i]).contentMode = UIViewContentModeScaleAspectFill;
        ((UIImageView*)self.imgAry[i]).clipsToBounds = YES;
    }
}

@end
