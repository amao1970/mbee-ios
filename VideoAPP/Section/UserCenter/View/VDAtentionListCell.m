//
//  VDAtentionListCell.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDAtentionListCell.h"

@implementation VDAtentionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.cancelbut.selected = isSelect;
    if (isSelect) {
        [self.cancelbut setTitle:@"取消关注" forState:UIControlStateNormal];
        [self.cancelbut setTitleColor:[UIColor hexStringToColor:@"898989"] forState:UIControlStateNormal];
        self.cancelbut.backgroundColor = [UIColor whiteColor];
        self.cancelbut.layer.cornerRadius = 5;
        self.cancelbut.layer.borderWidth = 0.5;
        self.cancelbut.layer.borderColor = [UIColor hexStringToColor:@"898989"].CGColor;
    }else{
        [self.cancelbut setTitle:@"关注" forState:UIControlStateNormal];
        [self.cancelbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancelbut.backgroundColor = [UIColor hexStringToColor:@"b28850"];
        self.cancelbut.layer.cornerRadius = 5;
        self.cancelbut.layer.borderWidth = 0;
    }
    self.cancelbut.titleLabel.font = FontSize(12);
}

@end
