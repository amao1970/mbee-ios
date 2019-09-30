//
//  SVCNavigationController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCNavigationController.h"

@interface SVCNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation SVCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor HxIsWaterBlueColor];
    self.navigationBar.titleTextAttributes =  [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"323232" andAlpha:1]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.backgroundColor = [UIColor hexStringToColor:@"323232"];
    
    self.navigationBar.translucent = NO;
    
    
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"323232" andAlpha:1]]];
    
    if (SystemVersion < 11) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 1000)
                                                             forBarMetrics:UIBarMetricsDefault];
    }else{
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
        
    }
    __weak typeof(self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) { self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
        
    }
    
    
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return self.interfaceOrientation;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return self.interfaceOrientationMask;
//}


//- (BOOL)shouldAutorotate{
//    return YES;
//}

//在视图进行压榨的时候隐藏底部的tabbar，该方法的实现避免许多不必要的操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 不是导航控制器的最底层
    UIViewController *fromViewController = self.topViewController;
    fromViewController.hidesBottomBarWhenPushed = YES;
//    if ([viewController.class isEqual:NSClassFromString(@"SVCLiveViewController")]) {
//        fromViewController.hidesBottomBarWhenPushed = NO;
//    }
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 5, 50, 25);
        btn.titleLabel.font = FontSize(15);
        btn.tintColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        //        [btn setTitle:@" 返回" forState:UIControlStateNormal];
        [btn addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 10);
        UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = back;
    }
    // 如果控制器等于导航控制器最底层
    if (fromViewController == self.viewControllers.firstObject) {
        fromViewController.hidesBottomBarWhenPushed = NO;
    }
}

- (void)goBack
{
    [self popViewControllerAnimated:YES];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]) { self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    return [super popToRootViewControllerAnimated:animated];
    
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    return [super popToViewController:viewController animated:animated];
    
}
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
        
    }
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer { if ( gestureRecognizer == self.interactivePopGestureRecognizer ) { if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] ) { return NO; } } return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
