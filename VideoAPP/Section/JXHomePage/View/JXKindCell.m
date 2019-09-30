//
//  JXKindCell.m
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXKindCell.h"

@implementation JXKindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JXKindModel *)model
{
    self.titleLab.text = model.title;
    self.img.backgroundColor = [UIColor clearColor];
    [self.img jx_setImageWithUrl:model.icon];
}

@end
