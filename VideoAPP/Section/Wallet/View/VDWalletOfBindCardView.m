//
//  VDWalletOfBindCardView.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDWalletOfBindCardView.h"

@implementation VDWalletOfBindCardView

-(void)awakeFromNib
{
    [super awakeFromNib];
//    [self.defaultView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_selectView)]];
}

-(void)click_selectView{
    self.selectBtn.selected = !self.selectBtn.isSelected;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.commit.layer.cornerRadius = 8;
    self.commit.clipsToBounds = YES;
    self.alipayBtn.layer.cornerRadius = 3;
    self.wechatPay.layer.cornerRadius = 3;
}

@end
