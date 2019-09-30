//
//  SVCHomePageLiveCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageLiveCell.h"

@implementation SVCHomePageLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
    // Initialization code
}

-(void)updateLiveWithModel:(SVCLiveModel*)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.img.layer.cornerRadius = self.img.height/2.f;
    self.img.clipsToBounds = YES;
    self.title.text = model.title;
    NSString *number = [NSString stringWithFormat:@"%@名主播在线",model.number];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:number];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor hexStringToColor:@"f75858"] range:NSMakeRange(0, model.number.length)];
    self.subtitle.attributedText = attString;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.enter.layer.cornerRadius = 3;
    self.img.layer.cornerRadius = self.img.height/2.f;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.borderColor = [[UIColor colorWithHexString:@"d5d5d5" andAlpha:1] CGColor];
}

@end
