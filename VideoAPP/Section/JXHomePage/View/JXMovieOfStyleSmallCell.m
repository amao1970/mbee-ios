//
//  JXMovieOfStyleSmallCell.m
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXMovieOfStyleSmallCell.h"

@implementation JXMovieOfStyleSmallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JXProductModel *)model
{
    self.titleLab.text = model.title;
    [self.img jx_setImageWithUrl:model.image];
    self.score.text = model.score;
}

@end
