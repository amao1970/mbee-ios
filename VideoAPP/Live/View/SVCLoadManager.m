//
//  SVCLoadManager.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/21.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLoadManager.h"

@interface SVCLoadManager()
/** 外圈图 */
@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UIView *bgView;

@end

@implementation SVCLoadManager

static SVCLoadManager *manager=nil;

+(instancetype)shareManagare{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight  - 160)];
    bgview.backgroundColor = [UIColor clearColor];
    self.bgView = bgview;
    
//    UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgview.width, bgview.height)];
//    alphaView.backgroundColor = [UIColor blackColor];
////    alphaView.alpha = 0.75;
//    [bgview addSubview:alphaView];
    
    UIImageView *imageW = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 40, (kScreenHeight - 160)/2 - 40, 80, 80)];
//    imageW.center = bgview.center;
    imageW.image = [UIImage imageNamed:@"jizai_waiquan"];
    [bgview addSubview:imageW];
    self.imageView = imageW;
    
    UIImageView *imageN = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 41/2, (kScreenHeight - 160)/2 - 44/2, 41, 39)];
//    imageN.center = imageW.center;
    imageN.image = [UIImage imageNamed:@"jizai_neiquan"];
    [bgview addSubview:imageN];
    
//    UILabel *loadLa = [[UILabel alloc]initWithFrame:CGRectMake(0, bgview.center.y+50, 80, 25)];
//    loadLa.centerX = bgview.centerX;
//    loadLa.text = @"加载中...";
//    loadLa.textAlignment = NSTextAlignmentCenter;
//    loadLa.textColor = [UIColor whiteColor];
//    [bgview addSubview:loadLa];
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

-(void)showLoadIng{
    [self startAnimation];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
}

-(void)HideLoadIng{
    [self stopAnimation];
    [self.bgView removeFromSuperview];
}







@end
