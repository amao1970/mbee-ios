//
//  JXTabBarBadge.h
//  JXTabBarController 
//
//  Created by  Admxjx on 16/7/1.
//  Copyright © 2016年  Admxjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTabBarBadge : UIButton

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 *  Tabbar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

@end
