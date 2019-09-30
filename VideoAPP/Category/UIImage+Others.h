//
//  UIImage+Others.h
//  WaterCommunity
//
//  Created by hxisWater on 15/10/14.
//  Copyright © 2015年 hxisWater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Others)
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+(UIImage*)convertViewToImage:(UIView*)view;

+ (void) GetImageViewWithUrl:(NSString *)ImageUrl BlockSuccess:(void(^)(UIImage *image))success;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight;

+ (UIImage *)loadImageWithImgName:(NSString *)imageName;

@end
