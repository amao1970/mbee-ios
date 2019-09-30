//
//  UIView+XMframe.h
//  baisi-one
//
//  Created by montnets on 16/8/31.
//  Copyright © 2016年 montnets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMframe)


@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat X;

@property (nonatomic,assign) CGFloat Y;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

@property (nonatomic,assign) CGSize size;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;


@end
