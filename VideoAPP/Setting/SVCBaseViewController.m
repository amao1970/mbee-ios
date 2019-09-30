//
//  SVCBaseViewController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCBaseViewController.h"
#import "RTRootNavigationController.h"

@interface SVCBaseViewController ()

@end

@implementation SVCBaseViewController



// 页面 开始渲染前
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /** 导航设置 */
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    [self.navigationController.navigationBar setBarTintColor: Color(50, 50, 50)];
    // 导航栏标题字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor hexStringToColor:@"cba677"]};
    
    
    // 透明
    self.navigationController.navigationBar.translucent = NO;
    
    UIImageView *tabImg = [self findHairlineImageViewUnder:self.tabBarController.tabBar];
    tabImg.hidden = YES;
    
    UIImageView *navImg = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navImg.hidden = YES;
}

// 去导航线条
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

// 状态栏 颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
//    if (self.navStyle == HMNavStyleOfred) {
        return UIStatusBarStyleLightContent;
//    }
//    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rt_disableInteractivePop = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // 增加滑动返回
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)disableInteractivePopOfInit
{
    self.rt_navigationController.rt_disableInteractivePop = YES;
    self.navigationController.rt_disableInteractivePop = YES;
    
    [self.rt_navigationController setRt_disableInteractivePop:YES];
    [self.navigationController setRt_disableInteractivePop:YES];
    [self setRt_disableInteractivePop:YES];
}

-(void)disableInteractivePopOfViewWill{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.rt_navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.rt_navigationController.interactivePopGestureRecognizer.delegate = self;
}

@end
