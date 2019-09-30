//
//  UITextField+JXMethods.m
//  publicRedPacket
//
//  Created by admso on 2018/10/9.
//

#import "UITextField+JXMethods.h"

@implementation UITextField (JXMethods)


-(void)set_margin:(NSInteger)M{
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, M, 0)];
    //设置显示模式为永远显示(默认不显示)
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void)set_placeholderColor:(UIColor*)color{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

@end
