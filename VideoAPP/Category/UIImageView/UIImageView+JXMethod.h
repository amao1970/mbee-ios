//
//  UIImageView+JXMethod.h
//  运营工具
//
//  Created by admso on 2017/3/15.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JXMethod)

-(void)jx_setImageWithUrl:(NSString*)url;
-(void)jx_setImageWithImageName:(NSString*)imgName;
-(void)jx_setHeadImgWithUrl:(NSString*)url;

// 设置圆角
-(void)jx_setCornerRadius:(float)cornerRadius;
-(void)jx_setUpCornerRadius;

@end
