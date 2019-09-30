//
//  SVCbuttonClickCell.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCbuttonClickCell.h"
@interface SVCbuttonClickCell()
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;

@end
@implementation SVCbuttonClickCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _logOutBtn.clipsToBounds = YES;
    _logOutBtn.layer.cornerRadius = 4.0f;
    // Initialization code
}
- (IBAction)LogoutbtnClick:(UIButton *)sender {
    if (self.Vdelegate && [self.Vdelegate respondsToSelector:@selector(LogoutClick)]) {
        [self.Vdelegate LogoutClick];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
