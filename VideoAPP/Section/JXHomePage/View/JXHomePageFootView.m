//
//  JXHomePageFootView.m
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXHomePageFootView.h"

@implementation JXHomePageFootView

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
    
}

@end
