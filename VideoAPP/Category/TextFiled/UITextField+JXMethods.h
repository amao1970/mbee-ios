//
//  UITextField+JXMethods.h
//  publicRedPacket
//
//  Created by admso on 2018/10/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (JXMethods)

// 设置左边距
-(void)set_margin:(NSInteger)M;
// 设置占位符字体颜色
-(void)set_placeholderColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
