//
//  BaseViewController.m
//
//
//  Created by admxjx on 15/7/2.
//  Copyright (c) 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTRootNavigationController;

@protocol RTNavigationItemCustomizable <NSObject>

@optional

- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action DEPRECATED_MSG_ATTRIBUTE("use rt_customBackItemWithTarget:action: instead!");
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action;

@end

IB_DESIGNABLE
@interface UIViewController (RTRootNavigationController) <RTNavigationItemCustomizable>

@property (nonatomic, assign) IBInspectable BOOL rt_disableInteractivePop;

@property (nonatomic, readonly, strong) RTRootNavigationController *rt_navigationController;

- (Class)rt_navigationBarClass;

@end
