//
//  JXCollectionViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXCollectionViewCell.h"

@implementation JXCollectionViewCell


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.contentView updateUI];
    }
    return self;
}

-(void)updateUI
{
    for (UIView *temp in self.subviews) {
        temp.frame = JXRectMake(temp.x, temp.y, temp.width, temp.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = JXRectMake(temp1.x, temp1.y, temp1.width, temp1.height);
        }
    }
}


@end
