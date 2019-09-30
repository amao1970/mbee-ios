//
//  UIViewController+YZHud.h
//  isWater
//
//  Created by hxisWater on 15/4/24.
//  Copyright (c) 2015年 HX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YZHud)

@property(nonatomic,strong)UIView *zhezhaoView;

-(void)hudShowWithtitle:(NSString *)title;

-(void)hudNil;

-(void)FailPop;

-(void)alertWithNSString:(NSString *)string;

-(void)addTitleViewWithTitle:(NSString *)title;


- (CGSize)contentSizeWithUILabel:(UILabel *)label;


-(void)PopViewController2S;

@end
