
//
//  BaseViewController.m
//
//
//  Created by admxjx on 15/7/2.
//  Copyright (c) 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#if RT_INTERACTIVE_PUSH
#import <RTInteractivePush/UINavigationController+InteractivePush.h>
#endif

#import "UIViewController+RTRootNavigationController.h"


@interface RTContainerController : UIViewController
@property (nonatomic, readonly, strong) __kindof UIViewController *contentViewController;
@end

@interface RTContainerNavigationController : UINavigationController
@end

IB_DESIGNABLE
@interface RTRootNavigationController : UINavigationController

@property (nonatomic, assign) IBInspectable BOOL useSystemBackBarButtonItem;

@property (nonatomic, assign) IBInspectable BOOL transferNavigationBarAttributes;

@property (nonatomic, readonly, strong) UIViewController *rt_visibleViewController;

@property (nonatomic, readonly, strong) UIViewController *rt_topViewController;

@property (nonatomic, readonly, strong) NSArray <__kindof UIViewController *> *rt_viewControllers;

- (instancetype)initWithRootViewControllerNoWrapping:(UIViewController *)rootViewController;

- (void)removeViewController:(UIViewController *)controller NS_REQUIRES_SUPER;
- (void)removeViewController:(UIViewController *)controller animated:(BOOL)flag NS_REQUIRES_SUPER;

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                  complete:(void(^)(BOOL finished))block;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated complete:(void(^)(BOOL finished))block;

- (NSArray <__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                      animated:(BOOL)animated
                                                      complete:(void(^)(BOOL finished))block;

- (NSArray <__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
                                                                  complete:(void(^)(BOOL finished))block;
@end
