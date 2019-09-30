//
//  SVCMineHeadView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCMineHeadView.h"

@implementation SVCMineHeadView

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headImg.clipsToBounds = YES;
    self.headImg.layer.cornerRadius = self.headImg.height/2.f;
    self.renewalBtn.clipsToBounds = YES;
    self.renewalBtn.layer.cornerRadius = self.renewalBtn.height/2.f;
    self.bgView.layer.cornerRadius = 5;
}

-(void)updateUIWithLogin:(BOOL)loginSuccess{
    self.unLogin.hidden = loginSuccess;
    self.nickName.hidden = !loginSuccess;
    self.dateLab.hidden = !loginSuccess;
    self.renewalBtn.hidden = !loginSuccess;
    if (loginSuccess) {
        SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
        self.nickName.text = user.nickname;
        if ([user.is_ever isEqualToString:@"1"]) {
            self.dateLab.text = @"终身会员";
        }else{
            self.dateLab.text = [NSString stringWithFormat:@"VIP到期时间：%@", [self gettime:user.end_time]];
        }
//        self.nickName.width = [self.nickName sizeThatFits:self.nickName.size].width+5;
//        self.renewalBtn.x = self.nickName.right+5;
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"默认图"]];
        
    }else{
        [self.renewalBtn setTitle:@"请续费" forState:UIControlStateNormal];
        self.nickName.text = @"";
        self.dateLab.text = @"";
        [self.headImg setImage:[UIImage imageNamed:@"huangguan"]];
        self.income.text = @"0";
        self.works.text = @"0";
        self.focus.text = @"0";
        self.collection.text = @"0";
    }
}

-(NSString *)gettime:(NSString *)timeStr{
    //    NSString *timeStampString  = @"1495453213000";
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStr doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

@end
