//
//  UIColor+JXMeth.h
//  lampStore
//
//  Created by admso on 2019/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JXMeth)
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end

NS_ASSUME_NONNULL_END
