//
//  JXTabBar.h
//  JXTabBarController 
//
//  Created by  Admxjx on 16/7/1.
//  Copyright © 2016年  Admxjx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JXTabBar, JXTabBarItem;

@protocol JXTabBarDelegate <NSObject>

@optional

- (void)tabBar:(JXTabBar *)tabBarView didSelectedItemFrom:(JXTabBarItem*)from to:(JXTabBarItem*)to;

@end



@interface JXTabBar : UIView

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

@property (nonatomic, assign) NSInteger tabBarItemCount;

@property (nonatomic, strong) JXTabBarItem *selectedItem;

@property (nonatomic, strong) NSMutableArray *tabBarItems;

@property (nonatomic, weak) id<JXTabBarDelegate> delegate;

- (void)addTabBarItem:(UITabBarItem *)item;

@end
