//
//  MBProgressHUD+BK.h
//  BaiKeLive
//
//  Created by simope on 16/6/3.
//  Copyright © 2016年 simope. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (BK)

/**
 *  此方法已废弃,使用：showOnlyTextToView: title:
 */
+ (void)showOnlyTextToView:(NSString *)message;


/**
 *  此方法已废弃,使用：showOnlyTextToView: title:
 */
+ (void)showOnlyTextToView:(NSString *)message ToView:(UIView *)view;


@end
