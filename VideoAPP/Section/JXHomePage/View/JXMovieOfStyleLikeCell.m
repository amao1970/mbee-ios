//
//  JXMovieOfStyleLikeCell.m
//  MovieApp
//
//  Created by admxjx on 2019/4/22.
//

#import "JXMovieOfStyleLikeCell.h"

#import "JXMovieOfLikeView.h"

@implementation JXMovieOfStyleLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

-(void)setList:(NSMutableArray *)list
{
    
    NSMutableArray <JXProductModel*> *tmpAry = [JXProductModel arrayOfModelsFromDictionaries:list];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    float MWidth = JXWidth(125);
    float VWidth = JXWidth(115);
    [tmpAry enumerateObjectsUsingBlock:^(JXProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JXMovieOfLikeView *view = [JXMovieOfLikeView getViewFormNSBunld];
        view.frame = CGRectMake(idx * MWidth, 0, VWidth, JXHeight(190));
        view.titleLab.text = obj.title;
        [view.img jx_setImageWithUrl:obj.image];
        [self.scrollView addSubview:view];
        
        self.scrollView.contentSize = CGSizeMake(idx * MWidth + MWidth, JXHeight(190));
    }];
}

@end
