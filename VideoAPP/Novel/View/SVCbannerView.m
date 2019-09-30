//
//  SVCbannerView.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCbannerView.h"
@interface SVCbannerView ()
@property (nonatomic , weak)UIImageView *bannerImagell;
@end
@implementation SVCbannerView
- (UIImageView *)bannerImagell
{
    if (!_bannerImagell) {
        UIImageView *imagell = [[UIImageView alloc] init];
        WS(weakSelf);
         [weakSelf addSubview:imagell];
        [imagell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(30);
            make.right.equalTo(weakSelf.mas_right).offset(-30);
            make.top.equalTo(weakSelf.mas_top).offset(15);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-15);
        }];
        _bannerImagell = imagell;
    }
    return _bannerImagell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)setbannerImage:(NSString *)imageName
{
    self.bannerImagell.image = [UIImage imageNamed:imageName];
}
- (void)tapClick
{
    if (self.Vdelegate && [self.Vdelegate respondsToSelector:@selector(bannerDidclick:)]) {
        [self.Vdelegate bannerDidclick:self.tag];
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
