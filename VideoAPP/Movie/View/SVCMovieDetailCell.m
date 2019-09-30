//
//  SVCMovieDetailCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCMovieDetailCell.h"

@implementation SVCMovieDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUpMovieModel:(SVCMoviePlayerModel*)model{
    self.score.hidden = !model.score.length;
    self.name.hidden = !model.name.length;
    self.score.text = model.score;
    self.score.width = [self.score sizeThatFits:self.score.size].width+13;
    self.name.text = model.name;
    self.name.width = [self.name sizeThatFits:self.name.size].width+13;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.title.text = model.title;
    self.title.height = [self.title sizeThatFits:self.title.size].height+20;
    self.attributeLab.text = model.attribute;
    self.attributeLab.width = [self.attributeLab sizeThatFits:self.attributeLab.size].width+13;
    self.attributeLab.hidden = !model.attribute.length;
    self.attributeLab.x = JXWidth(179) - self.attributeLab.width;
    if (!self.attributeLab.isHidden) {
        self.name.x = self.attributeLab.x - self.name.width - JXWidth(7);
    }else{
        self.name.x = JXWidth(179) - self.name.width;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.attributeLab.x = JXWidth(179) - self.attributeLab.width;
    self.score.y = self.image.bottom - JXWidth(5) - self.score.height;
    self.name.y = self.attributeLab.y;
    if (!self.attributeLab.isHidden) {
        self.name.x = self.attributeLab.x - self.name.width - JXWidth(7);
    }else{
        self.name.x = JXWidth(179) - self.name.width;
    }

}

@end
