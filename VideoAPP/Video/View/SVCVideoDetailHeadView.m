//
//  SVCVideoDetailHeadView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//


#import "SVCVideoDetailHeadView.h"


@interface SVCVideoDetailHeadView ()



@end

@implementation SVCVideoDetailHeadView

//-(void)reloadWitmModel:()

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.subtitleBgView.layer.cornerRadius = 5;
    self.subtitleBgView.clipsToBounds = YES;
    FLAnimatedImageView *advImg = [[FLAnimatedImageView alloc] init];
    advImg.contentMode = UIViewContentModeScaleAspectFill;
    advImg.clipsToBounds = YES;
    advImg.frame = self.advImg.frame;
    advImg.hidden = YES;
    [self.advImg removeFromSuperview];
    self.advImg = advImg;
    [self addSubview:self.advImg];
    
    FLAnimatedImageView *advBtn = [[FLAnimatedImageView alloc] init];
    advBtn.contentMode = UIViewContentModeScaleAspectFill;
    advBtn.clipsToBounds = YES;
    advBtn.frame = self.advBtn.frame;
//    advBtn.hidden = YES;
    [self.advBtn removeFromSuperview];
    self.advBtn = advBtn;
    [self addSubview:self.advBtn];
}

-(void)setVideoDetailInfo:(JXVideoInfoModel *)videoDetailInfo
{
    _videoDetailInfo = videoDetailInfo;
    self.titleLab.text = videoDetailInfo.title;
    self.titleLab.y = self.userBtn.bottom + 3;
    self.titleLab.height = [self.titleLab sizeThatFits:self.titleLab.size].height+5;
    if (self.titleLab.height > JXHeight(45)) {
        self.titleLab.height = JXHeight(45);
    }
    [self.headImg jx_setImageWithUrl:videoDetailInfo.authoravatar];
    self.nickNameLab.text = [NSString stringWithFormat:@"%@",videoDetailInfo.authornick];
    self.fansLab.text = [NSString stringWithFormat:@"%@",videoDetailInfo.createtime];
    self.subtitleLab.text =  [self.subtitleLab.text stringByAppendingFormat:@" %@",videoDetailInfo.brief];
    self.subtitleLab.height = [self.subtitleLab sizeThatFits:self.subtitleLab.size].height;
    self.subtitleBgView.height = self.subtitleLab.height + 5;
    if (videoDetailInfo.brief.length <=0) {
        self.subtitleLab.text = @"暂无简介";
    }
    if (!self.playNum.text.length) {
        NSInteger lookNum = arc4random() % 190;
        lookNum+=10;
        self.playNum.text = [NSString stringWithFormat:@"原创 | %ld万次播放",lookNum];
    }
    self.playNum.y = self.titleLab.bottom;
    if (self.tagView.subviews.count>0) return;
    self.tagView.padding = UIEdgeInsetsMake( 4, 0, 10, 10);
    self.tagView.interitemSpacing = 10;
    self.tagView.lineSpacing = 10;
    self.tagView.clipsToBounds = YES;
    self.tagView.didTapTagAtIndex = ^(NSUInteger index){
        // 点击事件
        NSLog(@"点击事件%ld",index);
    };
    
    self.tagView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [videoDetailInfo.tag enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKTag *tag = [SKTag tagWithText: obj];
        tag.textColor = [UIColor hexStringToColor:@"8b8787"];
        tag.bgColor = [UIColor hexStringToColor:@"e7e6e6"];
        tag.font = [UIFont systemFontOfSize:12];
        tag.padding = UIEdgeInsetsMake(2, 4, 2, 4);
        tag.cornerRadius = 2;
        [self.tagView addTag:tag];
    }];
    
    [self addSubview:self.tagView];
    [self setNeedsLayout];
    [self layoutSubviews];
    [self.tagView layoutSubviews];
    self.tagView.height = JXHeight(24);
}

-(void)setBannerInfo:(NSDictionary *)bannerInfo
{
    _bannerInfo = bannerInfo;
//    
    [self.advBtn sd_setImageWithURL:[NSURL URLWithString:bannerInfo[@"image"]] placeholderImage:[UIImage imageNamed:@"默认图"]];
}

-(void)setUpShow{
    if (self.show.isSelected) {
        self.titleLab.numberOfLines = 0;
        self.titleLab.height = [self.titleLab sizeThatFits:self.titleLab.size].height+5;
        self.playNum.y = self.titleLab.bottom;
        self.tagView.y = self.playNum.bottom;
        self.subtitleLab.y = self.tagView.bottom+JXHeight(5);
        self.tagView.hidden = NO;
        self.subtitleLab.hidden = NO;
        self.subtitleBgView.hidden = NO;
        self.subtitleBgView.centerY = self.subtitleLab.centerY;
        self.advBtn.y = self.subtitleBgView.bottom + JXHeight(5);
        self.height = self.advBtn.bottom + 5;
        self.line.y = self.height-0.5;
    }else{
        self.titleLab.numberOfLines = 1;
        self.titleLab.height = [self.titleLab sizeThatFits:self.titleLab.size].height+5;
        self.playNum.y = self.titleLab.bottom;
        self.tagView.hidden = YES;
        self.subtitleLab.hidden = YES;
        self.subtitleBgView.hidden = YES;
        self.advBtn.y = self.playNum.bottom + 5;
        self.height = self.advBtn.bottom + 5;
        self.line.y = self.height-0.5;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (IsIphone5a5c5s) {
////        self.titleLab.y = self.advBtn.bottom;
////        self.titleLab.y = self.userBtn.bottom + 3;
////        self.titleLab.font = [UIFont systemFontOfSize:13];
////        self.titleLab.height = 21;
        self.tagView.height = 23;
    }
    self.tagView.y = self.playNum.bottom;
    self.tagView.x = self.playNum.x;
//    self.subtitleLab.y = self.tagView.bottom;
//    self.line.y = self.height - 1;
//    self.line.x = 5;
}

@end
