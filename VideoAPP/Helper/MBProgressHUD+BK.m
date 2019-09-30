//
//  MBProgressHUD+BK.m
//  BaiKeLive
//
//  Created by simope on 16/6/3.
//  Copyright © 2016年 simope. All rights reserved.
//

#import "MBProgressHUD+BK.h"

@implementation MBProgressHUD (BK)

//快速显示一条提示信息
+ (void)showOnlyTextToView:(NSString *)message {
    [self showOnlyTextToView:message ToView:nil];
}

//自动消失提示，无图
+ (void)showOnlyTextToView:(NSString *)message ToView:(UIView *)view {
    [self showMessage:message ToView:view RemainTime:1.0 Model:MBProgressHUDModeText];
}

+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time Model:(MBProgressHUDMode)model {

    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    //模式
    hud.mode = model;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    // X秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

@end
