//
//  SVCNovelTableViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCNovelTableViewCell.h"
@interface SVCNovelTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *novelLabel;


@end

@implementation SVCNovelTableViewCell

static NSString *SVCNovelTableViewCellID = @"SVCNovelTableViewCellID";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    SVCNovelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SVCNovelTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
   self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setNovelName:(NSString *)novelName {
    _novelName = novelName;
    _novelLabel.text = novelName;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
