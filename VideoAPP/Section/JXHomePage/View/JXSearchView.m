//
//  JXSearchView.m
//  MovieApp
//
//  Created by admxjx on 2019/4/26.
//

#import "JXSearchView.h"

@implementation JXSearchView

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.searchView.layer.cornerRadius = self.searchView.height/2.f;
    self.searchView.clipsToBounds = YES;
//    self.searchView.centerX = self.width/2.f;
}

@end
