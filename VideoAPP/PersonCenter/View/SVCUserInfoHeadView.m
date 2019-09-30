//
//  SVCUserInfoHeadView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCUserInfoHeadView.h"

@implementation SVCUserInfoHeadView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.monthOnLineView.layer.cornerRadius = 3;
    self.monthOnLineView.clipsToBounds = YES;
    self.quarterOnLineView.layer.cornerRadius = 3;
    self.quarterOnLineView.clipsToBounds = YES;
    self.halfYearOnLineView.layer.cornerRadius = 3;
    self.halfYearOnLineView.clipsToBounds = YES;
    self.yearOnLineView.layer.cornerRadius = 3;
    self.yearOnLineView.clipsToBounds = YES;
    
    self.monthView.layer.cornerRadius = 3;
    self.quarterView.layer.cornerRadius = 3;
    self.halfYearView.layer.cornerRadius = 3;
    self.yearView.layer.cornerRadius = 3;
    self.monthView.clipsToBounds = YES;
    self.quarterView.clipsToBounds = YES;
    self.halfYearView.clipsToBounds = YES;
    self.yearView.clipsToBounds = YES;
    
    self.monthView.layer.borderWidth = 1;
    self.monthView.layer.borderColor = Color(232, 232, 232).CGColor;
    
    self.quarterView.layer.borderWidth = 1;
    self.quarterView.layer.borderColor = Color(232, 232, 232).CGColor;
    
    self.halfYearView.layer.borderWidth = 1;
    self.halfYearView.layer.borderColor = Color(232, 232, 232).CGColor;
    
    self.yearView.layer.borderWidth = 1;
    self.yearView.layer.borderColor = Color(232, 232, 232).CGColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.rechargeBtn.layer.cornerRadius = 5;
}

@end
