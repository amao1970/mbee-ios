//
//  UIScrollView+JXMethod.m
//  运营工具
//
//  Created by admso on 2017/3/15.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import "UIScrollView+JXMethod.h"

@implementation UIScrollView (JXMethod)
-(void)hiddenIndicator
{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}
@end
