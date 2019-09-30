//
//  Xuebei
//
//  Created by maceasy on 15/11/25.
//  Copyright © 2015年 macHY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSYToastView.h"

@interface UIView (WSYToast)

@property (nonatomic,weak) WSYToastView *toastView;

- (void)toastShow:(NSString *)text;

@end
