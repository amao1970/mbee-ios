//
//  SVCADViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//


#import "SVCADViewController.h"
#import "SVCCommunityApi.h"

@interface SVCADViewController ()
@property(nonatomic, strong) UIImageView *adImageView; /**<广告图片 */
@property(nonatomic, strong) UIButton *timerButton; /**<倒计时按钮 */
@property(nonatomic, strong) NSTimer *timer; /**<定时器 */
@end

@implementation SVCADViewController

- (UIImageView *)adImageView{
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_adImageView];
    }
    return _adImageView;
}

- (UIButton *)timerButton{
    if (_timerButton) {
        _timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timerButton.frame = CGRectMake(GetWidthByScreenWidth(310), GetHeightByScreenHeigh(44), GetWidthByScreenWidth(40), GetHeightByScreenHeigh(30));
        [_timerButton setTitle:@"3S" forState:UIControlStateNormal];
        
    }
    return _timerButton;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            // 广告图加载不出来  回到主页
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.timerButton];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)timerFired{
    
}



@end
