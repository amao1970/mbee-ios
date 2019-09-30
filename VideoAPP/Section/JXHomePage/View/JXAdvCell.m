//
//  JXAdvCell.m
//  MovieApp
//
//  Created by admxjx on 2019/4/22.
//

#import "JXAdvCell.h"

@implementation JXAdvCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JXAdvModel *)model
{
    self.titleLab.text = model.title;
    [self.img jx_setImageWithUrl:model.image];
}

@end
