//
//  UIViewController+YZHud.m
//  isWater
//
//  Created by hxisWater on 15/4/24.
//  Copyright (c) 2015年 HX. All rights reserved.
//

#import "UIViewController+YZHud.h"
#import "WSProgressHUD.h"
#import <objc/runtime.h>

@implementation UIViewController (YZHud)
@dynamic zhezhaoView;

-(void)hudNil{
    [WSProgressHUD dismiss];
}
-(void)hudShowWithtitle:(NSString *)title{
    [WSProgressHUD showWithStatus:title maskType:WSProgressHUDMaskTypeBlack];
}


-(void)FailPop{
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}
-(void)addTitleViewWithTitle:(NSString *)title{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.textColor=[UIColor whiteColor];
    label.text=title;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.navigationItem setTitleView:label];
    
}
-(void)removeFailView{
    
    [self.zhezhaoView removeFromSuperview];
    self.zhezhaoView=nil;
    
    NSLog(@"subViewCount:%zd",self.view.subviews.count);
}


-(void)alertWithNSString:(NSString *)string{
    
    if (![string isKindOfClass:[NSString class]]) {
        string=@"error";
    }

    
    [WSProgressHUD showImage:nil status:string];
}

-(void)removeAlertWithView:(UIView *)view{
    [view removeFromSuperview];
}

-(UIView *)zhezhaoView{
    return objc_getAssociatedObject(self, @selector(zhezhaoView));
}

-(void)setZhezhaoView:(UIView *)zhezhaoView{
    objc_setAssociatedObject(self, @selector(zhezhaoView), zhezhaoView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)contentSizeWithUILabel:(UILabel *)label{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = label.lineBreakMode;
    paragraphStyle.alignment = label.textAlignment;
    NSDictionary * attributes = @{NSFontAttributeName : label.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    CGSize contentSize = [label.text boundingRectWithSize:label.frame.size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}


-(void)PopViewController2S{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
