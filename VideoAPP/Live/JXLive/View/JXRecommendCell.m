//
//  JXRecommendCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXRecommendCell.h"

@interface JXRecommendCell ()

@property (nonatomic, assign) BOOL haveAn;

@end

@implementation JXRecommendCell

-(void)reloadWithModel:(JXRecommendModel*)model{
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"默认图"]];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.nameLab.text = model.title;
    
    self.bgImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImg.clipsToBounds = YES;
    self.headImg.contentMode = UIViewContentModeScaleAspectFill;
    self.headImg.clipsToBounds = YES;
    
    if (!self.audienceLab.text.length) {
        NSInteger lookNum = arc4random() % 49000;
        lookNum+=1000;
        self.audienceLab.text = [NSString stringWithFormat:@"观众：%ld人",(long)lookNum];
    }
    
    if (!self.fansLab.text.length) {
        NSInteger lookNum = arc4random() % 100;
        lookNum+=1;
        self.fansLab.text = [NSString stringWithFormat:@"%.1ld万粉丝",(long)lookNum];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headImg.layer.cornerRadius = self.headImg.height/2.f;
    self.subtitleLab.clipsToBounds = YES;
    self.subtitleLab.layer.cornerRadius = self.subtitleLab.height/2.f;
    
    self.bgView.layer.cornerRadius = self.bgView.width/2.f;
    self.bgView1.layer.cornerRadius = self.bgView.width/2.f;
    self.bgView2.layer.cornerRadius = self.bgView.width/2.f;
    
    [self setUpAnimationWithView:self.bgView timeOffset:0];
    [self setUpAnimationWithView:self.bgView1 timeOffset:0.15];
    [self setUpAnimationWithView:self.bgView2 timeOffset:0.3];
}

-(void)setUpAnimationWithView:(UIView*)view timeOffset:(CGFloat)timeOffset{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation1.fromValue = [NSValue valueWithCGRect:CGRectMake(view.x, 87, 2, 12)];
    animation1.toValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y, view.width, 3)];
    CABasicAnimation *animation2 =[CABasicAnimation animationWithKeyPath:@"position"];
    animation2.fromValue = [NSValue valueWithCGPoint:view.layer.position];;
    animation2.toValue = [NSValue valueWithCGPoint:view.layer.position];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.3;
    group.repeatCount = MAXFLOAT;
    group.autoreverses = YES;
    group.removedOnCompletion = NO;
    group.timeOffset = timeOffset;
    group.animations = [NSArray arrayWithObjects:animation1, animation2, nil];
    [view.layer addAnimation:group forKey:@"move-rotate-layer"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.haveAn) {
        self.haveAn = YES;
        
    }
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
