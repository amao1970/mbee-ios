//
//  JXSearchHotListCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXSearchHotListCell.h"

@implementation JXSearchHotListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.line.y = self.height - self.line.height;
}

@end
