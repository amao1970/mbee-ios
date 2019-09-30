//
//  UIViewController+JXMethods.m
//  publicRedPacket
//
//  Created by admso on 2018/10/9.
//

#import "UIViewController+JXMethods.h"

@implementation UIViewController (JXMethods)



-(void)setBackImgWithImg:(NSString*)imageStr{
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    [backImg setImage:[UIImage imageNamed:imageStr]];
   
    
    [self.view addSubview:backImg];
    [self.view sendSubviewToBack:backImg];
}

@end
