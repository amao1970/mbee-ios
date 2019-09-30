//
//  JXTableViewCell.m
//  webSnifferLW
//
//  Created admxjx on 2017/6/27.
//
//

#import "JXTableViewCell.h"

@implementation JXTableViewCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self updateUI];
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
