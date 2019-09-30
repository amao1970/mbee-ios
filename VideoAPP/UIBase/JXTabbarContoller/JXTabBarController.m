//
//  JXTabBarController.m
//  JXTabBarController 
//
//  Created by  Admxjx on 16/7/1.
//  Copyright © 2016年  Admxjx. All rights reserved.
//

/**
 * tabbarController模块
 */

#import "JXTabBarController.h"
#import "JXTabBar.h"
#import "JXTabBarCONST.h"
#import "JXTabBarItem.h"
#import "RTRootNavigationController.h"


// 导航
#import "SVCNavigationController.h"
#import "VDHomePageVC.h"
#import "SVCVideoViewController.h"
#import "SVCImageViewController.h"
#import "SVCHomePageViewController.h"
#import "SVCOriginateNovelViewController.h"
#import "SVCPersonCenterViewController.h"
#import "SVCMovieViewController.h"
#import "SVCMineVC.h"
#import "VDUploadVideoVC.h"
#import "SVCAllLiveViewController.h"
#import "SVCVideoViewController.h"

#import "VDWalletMainVC.h"
#import "VDKindVC.h"

@interface JXTabBarController () <JXTabBarDelegate>

@property (nonatomic, strong) JXTabBar *JXTabBar;

@end

@implementation JXTabBarController

#pragma mark -

- (UIColor *)itemTitleColor {
    
    if (!_itemTitleColor) {
        
        _itemTitleColor = MSColorForTabBar(117, 117, 117);
    }
    return _itemTitleColor;
}

- (UIColor *)selectedItemTitleColor {
    
    if (!_selectedItemTitleColor) {
        
        _selectedItemTitleColor = [UIColor hexStringToColor:@"ffc100"];//MSColorForTabBar(234, 103, 7);
    }
    return _selectedItemTitleColor;
}

- (UIFont *)itemTitleFont {
    
    if (!_itemTitleFont) {
        
        _itemTitleFont = [UIFont systemFontOfSize:11.0f];
    }
    return _itemTitleFont;
}

- (UIFont *)badgeTitleFont {
    
    if (!_badgeTitleFont) {
        
        _badgeTitleFont = [UIFont systemFontOfSize:11.0f];
    }
    return _badgeTitleFont;
}

#pragma mark -

- (void)loadView {
    
    [super loadView];
    
    self.itemImageRatio = 0.70f;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUpViewControllers];
    }
    return self;
}

-(void)setUpViewControllers{

    VDHomePageVC *vc1 = [[VDHomePageVC alloc] init];
//    HMHomePageViewController *vc1 = [HMHomePageViewController new];
    //vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"live_wxz"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"live_xz"];
    
    VDUploadVideoVC *vc2 = [[VDUploadVideoVC alloc] init];
    vc2.title = @"发布";
    vc2.tabBarItem.image = [UIImage imageNamed:@"yunb_wxz"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"yunbo_xz"];
    
    SVCMineVC *vc3 = [[SVCMineVC alloc] init];
    vc3.title = @"我的";
    vc3.tabBarItem.image = [UIImage imageNamed:@"wode_wxz"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"wode_xz"];
    
//    VDWalletMainVC *vc4 = [[VDWalletMainVC alloc] init];
    SVCAllLiveViewController *vc4 = [[SVCAllLiveViewController alloc] init];
    vc4.title = @"直播";
    vc4.tabBarItem.image = [UIImage imageNamed:@"yingshi_wxz"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"yingshi__xz"];
    
    VDKindVC *vc5 = [[VDKindVC alloc] init];
    vc5.title = @"视频";
    vc5.tabBarItem.image = [UIImage imageNamed:@"电影_unselect"];
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"电影_select"];
    
    RTRootNavigationController *navC1 = [[RTRootNavigationController alloc] initWithRootViewController:vc1];
    RTRootNavigationController *navC2 = [[RTRootNavigationController alloc] initWithRootViewController:vc2];
    RTRootNavigationController *navC3 = [[RTRootNavigationController alloc] initWithRootViewController:vc3];
    RTRootNavigationController *navC4 = [[RTRootNavigationController alloc] initWithRootViewController:vc4];
    RTRootNavigationController *navC5 = [[RTRootNavigationController alloc] initWithRootViewController:vc5];
    
    self.viewControllers = @[ navC1, navC5, navC4, navC3]; //navC5, navC2
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tabBar addSubview:({
        
        JXTabBar *tabBar = [[JXTabBar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.delegate  = self;
        
        self.JXTabBar = tabBar;
    })];
    self.view.backgroundColor = [UIColor hexStringToColor:@"323232"];
//    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor colorWithHexString:@"2b2b2b" andAlpha:1];
    // 添加阴影
    self.tabBar.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tabBar.layer.shadowOpacity = 0.3;
    self.tabBar.clipsToBounds = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self removeOriginControls];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self removeOriginControls];
}

- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIControl class]]) {
            if (@available(iOS 11.0, *)) {
                obj.hidden = YES;
            } else {
                [obj removeFromSuperview];
                obj.hidden = YES;
            }
        }
    }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    self.JXTabBar.badgeTitleFont         = self.badgeTitleFont;
    self.JXTabBar.itemTitleFont          = self.itemTitleFont;
    self.JXTabBar.itemImageRatio         = self.itemImageRatio;
    self.JXTabBar.itemTitleColor         = self.itemTitleColor;
    self.JXTabBar.selectedItemTitleColor = self.selectedItemTitleColor;
    
    self.JXTabBar.tabBarItemCount = viewControllers.count;
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:VC];
        
        [self.JXTabBar addTabBarItem:VC.tabBarItem];
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    self.JXTabBar.selectedItem.selected = NO;
    self.JXTabBar.selectedItem = self.JXTabBar.tabBarItems[selectedIndex];
    self.JXTabBar.selectedItem.selected = YES;
}

#pragma mark - XXTabBarDelegate Method

- (void)tabBar:(JXTabBar *)tabBarView didSelectedItemFrom:(JXTabBarItem*)from to:(JXTabBarItem*)to {
    
//    if (to.tag == 3 && ![HMTokenManager haveToken]) {
//        NSLog(@"__nav_%@_",self.viewControllers.lastObject.childViewControllers);
//        for (UIViewController *VC in ((RTRootNavigationController*)self.viewControllers.lastObject).rt_viewControllers) {
//            if ([VC isKindOfClass:NSClassFromString(@"HMUserCenterViewController")]) {
//                ((HMUserCenterViewController*)VC).showLogin = YES;
//            }
//        }
//    }
    
    // 切换
    self.selectedIndex = to.tag;
    
    tabBarView.selectedItem.selected = NO;
    tabBarView.selectedItem = to;
    tabBarView.selectedItem.selected = YES;
}

@end
