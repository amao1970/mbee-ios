//
//  SVCTVLiveLeftCell.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTVLiveLeftCell.h"

@interface SVCTVLiveLeftCell()
@property (weak, nonatomic) IBOutlet UIView *leftMarkView;
@property (weak, nonatomic) IBOutlet UIView *marginView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginHeightCos;

@end

@implementation SVCTVLiveLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
static NSString *SVCTVLiveLeftCellID = @"SVCTVLiveLeftCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    SVCTVLiveLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:SVCTVLiveLeftCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setNameString:(NSString *)nameString{
    _nameString = nameString;
    _nameLabel.text = nameString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _nameLabel.textColor = SVCColorFromRGB(0xff2200);
        _leftMarkView.backgroundColor = SVCColorFromRGB(0xff2200);
    }else{
        _nameLabel.textColor = SVCColorFromRGB(0x333333);
        _leftMarkView.backgroundColor = [UIColor clearColor];
    }
}


@end
