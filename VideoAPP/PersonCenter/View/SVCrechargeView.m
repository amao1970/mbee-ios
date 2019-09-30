//
//  SVCrechargeView.m
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCrechargeView.h"
@interface SVCrechargeView ()
{
    UIImageView *_bgImagell;
    UILabel *_typeLab;
}
@end
@implementation SVCrechargeView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    _bgImagell = [[UIImageView alloc] init];
    _bgImagell.frame = self.bounds;
    _bgImagell.image = showImage(@"icon_chongzhidi");
//    _bgImagell.tintColor = [UIColor hexStringToColor:@"f75858"];
    [self addSubview:_bgImagell];
    _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)/4 - 12.5, self.bounds.size.width, 25)];
    _typeLab.textColor = [UIColor whiteColor];
    _typeLab.textAlignment = NSTextAlignmentCenter;
    _typeLab.font = kFont(16);
    [self addSubview:_typeLab];
  UILabel * coinLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)*3/4 - 12.5, self.bounds.size.width, 25)];
    coinLab.font = kFont(13);
    coinLab.textColor = [UIColor whiteColor];
    coinLab.textAlignment = NSTextAlignmentCenter;
    coinLab.text = @"充值";
    [self addSubview:coinLab];
    
}
- (void)setrechargeLabtext:(NSString *)title{
    _typeLab.text = title;
}
- (void)tapClick
{
    if (self.Vdelegate && [self.Vdelegate respondsToSelector:@selector(rechargeViewDidclick:)]) {
        [self.Vdelegate rechargeViewDidclick:self.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
