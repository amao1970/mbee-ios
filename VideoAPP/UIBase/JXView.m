//
//  JXView.m
//  TradeCoin
//
//  Created by admxjx on 2018/9/3.
//  Copyright © 2018年 lili lili. All rights reserved.
//

#import "JXView.h"

@implementation JXView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self updateUI];
    }
    return self;
}

@end
