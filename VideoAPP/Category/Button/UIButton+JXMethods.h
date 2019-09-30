//
//  UIButton+JXMethods.h
//  运营工具
//
//  Created admso on 2017/3/20.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JXMethods)
-(void)jx_setImageWithUrlString:(NSString*)image;
-(void)jx_setBackgroundImageWithUrlString:(NSString*)image;
-(void)jx_setImageWithimgName:(NSString*)image;
-(void)jx_setHighlightedWithColor:(UIColor*)color;
-(void)jx_setNormalWithColor:(UIColor*)color;
-(void)jx_setSelectedWithColor:(UIColor*)color;
@end
