//
//  JXHomePageHeadView.m
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXHomePageHeadView.h"

@implementation JXHomePageHeadView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self updateUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat imageWidth = self.moreBtn.imageView.bounds.size.width;
    CGFloat labelWidth = self.moreBtn.titleLabel.bounds.size.width;
    self.moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth+5);
}

@end
