//
//  SVCTVLiveRightCell.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTVLiveRightCell.h"

@interface SVCTVLiveRightCell()
@property (weak, nonatomic) IBOutlet UIView *marginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginViewHeightCos;
@property (weak, nonatomic) IBOutlet UILabel *TVNameLabel;

@end

@implementation SVCTVLiveRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

static NSString *SVCTVLiveRightCellID = @"SVCTVLiveRightCellID";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    SVCTVLiveRightCell *cell = [tableView dequeueReusableCellWithIdentifier:SVCTVLiveRightCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        
    }
    return cell;
}


- (void)setTVNameStr:(NSString *)TVNameStr{
    _TVNameStr = TVNameStr;
    _TVNameLabel.text = TVNameStr;
}

@end
