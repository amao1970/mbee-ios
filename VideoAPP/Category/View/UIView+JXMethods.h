//
//  UIView+JXMethods.h
//  webSnifferLW
//
//  Created admso on 2017/6/27.
//
//

#import <UIKit/UIKit.h>

@interface UIView (JXMethods)

// 添加水平线
-(void)addHorizontalLine;

+(instancetype)getViewFormNSBunld;
-(void)updateUI;

// 设置圆角
-(void)jx_setCornerRadius:(float)cornerRadius;
-(void)jx_setUpCornerRadius;

@end
