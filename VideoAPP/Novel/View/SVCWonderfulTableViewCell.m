//
//  SVCWonderfulTableViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCWonderfulTableViewCell.h"
#import "SVCWonderfulVideoModel.h"

@interface SVCWonderfulTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SVCWonderfulTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconView.backgroundColor = SVCMainColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

static NSString *SVCWonderfulTableViewCellID = @"SVCWonderfulTableViewCellID";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    SVCWonderfulTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SVCWonderfulTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setVideoModel:(SVCWonderfulVideoModel *)videoModel{
    _videoModel = videoModel;
    self.nameLabel.text = videoModel.title;
    if (videoModel.image.length) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:videoModel.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
         self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
         self.iconView.contentMode = UIViewContentModeCenter;
        self.iconView.image = [UIImage imageNamed:@"mideo_icon"];
       
    }
}

@end
