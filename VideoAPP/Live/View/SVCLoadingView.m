//
//  SVCLoadingView.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/21.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLoadingView.h"

@interface SVCLoadingView ()
/** 外圈图 */
@property (nonatomic,strong)UIImageView *imageView;


@end

@implementation SVCLoadingView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 80)];
    bgview.backgroundColor = [UIColor blackColor];
    bgview.alpha=1;
    [self addSubview:bgview];
    
    UIImageView *imageW = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageW.center = self.center;
    imageW.image = [UIImage imageNamed:@"jizai_waiquan"];
    [self addSubview:imageW];
    self.imageView = imageW;
    [self startAnimation];
    
    UIImageView *imageN = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 41, 39)];
    imageN.center = self.center;
    imageN.image = [UIImage imageNamed:@"jizai_neiquan"];
    [self addSubview:imageN];
    
//    UILabel *loadLa = [[UILabel alloc]initWithFrame:CGRectMake(0, self.center.y+50, 80, 25)];
//    loadLa.centerX = self.centerX;
//    loadLa.text = @"加载中...";
//    loadLa.textAlignment = NSTextAlignmentCenter;
//    loadLa.textColor = [UIColor whiteColor];
//    [self addSubview:loadLa];
}

-(void)startAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount =ULLONG_MAX;
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)stopAnimation{
    [self.imageView.layer removeAllAnimations];
}

-(void)loadViewRemove{
    [self stopAnimation];
    sleep(1);
    [self removeFromSuperview];
}





@end
