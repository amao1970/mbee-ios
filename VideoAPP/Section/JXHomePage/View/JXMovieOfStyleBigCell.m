//
//  JXMovieOfStyleBigCell.m
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXMovieOfStyleBigCell.h"

@implementation JXMovieOfStyleBigCell


-(void)setModel:(JXProductModel *)model
{
    self.titleLab.text = model.title;
    [self.img jx_setImageWithUrl:model.image];
    self.score.text = model.score;
}


@end
