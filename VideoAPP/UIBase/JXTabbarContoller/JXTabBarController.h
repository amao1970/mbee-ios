//
//  JXTabBarController.h
//  JXTabBarController 
//
//  Created by  Admxjx on 16/7/1.
//  Copyright © 2016年  Admxjx. All rights reserved.
//
//
//
//
//  V 1.3.3

#import <UIKit/UIKit.h>

/**
 *  nav and VC
 */

//#import "RTRootNavigationController.h"

@interface JXTabBarController : UITabBarController

/**
 *  Tabbar item title color
 */
@property (nonatomic, strong) UIColor *itemTitleColor;

/**
 *  Tabbar selected item title color
 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

/**
 *  Tabbar item title font
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 *  Tabbar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

/**
 *  Tabbar item image ratio
 */
@property (nonatomic, assign) CGFloat itemImageRatio;


/**
 *  删除源控制, for `- popToRootViewController`
 */
- (void)removeOriginControls;


-(void)updateTabBarVC;
@end
