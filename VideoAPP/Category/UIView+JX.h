//
//  UIView+JX.h
//  TradeCoin
//
//  Created by admxjx on 2018/8/17.
//  Copyright © 2018年 lili lili. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewLineStyle) {
    UIViewLineStyleLeftSpace,
    UIViewLineStyleRightSpace,
    UIViewLineStyleLeftAndRightSpace,
    UIViewLineStyleNoneSpace
};

@interface UIView (JX)

-(void)updateUI;
+(instancetype)getViewFormNSBunld;
@property (strong, nonatomic) UIView *line;
-(void)addLineWith:(UIViewLineStyle)lineStyle;

@end
