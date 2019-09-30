//
//  SVCShareView.m
//  SmartValleyCloudSeeding
//
//  Created by Mac on 2018/8/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCShareView.h"

@implementation SVCShareView

- (void)awakeFromNib{
    [super awakeFromNib];
    _firstCons.constant = (SCREEN_WIDTH - 35 * 4) / 5;
   
    _secondCons.constant = (SCREEN_WIDTH - 35 * 4) / 5;
    _thirdCons.constant = (SCREEN_WIDTH - 35 * 4) / 5;
    _fourthCOns.constant = (SCREEN_WIDTH - 35 * 4) / 5;
    
}
+ (instancetype)shareView{
    return [[NSBundle mainBundle] loadNibNamed:@"SVCShareView" owner:nil options:nil].lastObject;
}

- (IBAction)shareButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareView:didClickButtonWithIndex:)]) {
        [self.delegate shareView:self didClickButtonWithIndex:sender.tag];
    }
}


@end
