//
//  SVCPersoncenterHeaderView.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCPersoncenterHeaderView.h"
@interface SVCPersoncenterHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *userIdLab;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeEndLab;
@property (weak, nonatomic) IBOutlet UIButton *longinBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImagell;

@end
@implementation SVCPersoncenterHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _longinBtn.clipsToBounds = YES;
    _longinBtn.layer.cornerRadius = 4.0;
    _longinBtn.layer.borderWidth = 1.0f;
    _longinBtn.layer.borderColor = [UIColor hexStringToColor:@"eeeeee"].CGColor;
}
- (void)setupHeaderUI:(BOOL)ret
{
    [self shwoUserInfoWithret:ret];
    if (!ret) {
        SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
        _userIdLab.text = [NSString stringWithFormat:@"ID：%@",user.nickname_code];
        _nickNameLab.text = [NSString stringWithFormat:@"昵称：%@",user.nickname];
        NSString *timeStr = [self gettime:user.end_time];
        if ([user.is_ever isEqualToString:@"1"]) {
            _timeEndLab.text = @"终身会员";
        }else{
            _timeEndLab.text = [NSString stringWithFormat:@"VIP到期时间：%@",timeStr];
        }
       
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

- (void)shwoUserInfoWithret:(BOOL)ret
{
    _longinBtn.hidden = !ret;
    _userIdLab.hidden = ret;
    _nickNameLab.hidden = ret;
    _timeEndLab.hidden = ret;
//    _headerImagell.hidden = ret;
}
- (IBAction)loginBtnClick:(UIButton *)sender {
    if (self.Vdelegate && [self.Vdelegate respondsToSelector:@selector(LoginClick)]) {
        [self.Vdelegate LoginClick];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
