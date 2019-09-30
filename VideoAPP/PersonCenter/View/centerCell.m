//
//  centerCell.m
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "centerCell.h"
@interface centerCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *centImgell;
@end
@implementation centerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupUIwithimageName:(NSString *)imageName title:(NSString *)title
{
    _titleLab.text = title;
    _centImgell.image = showImage(imageName);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
