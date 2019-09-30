//
//  SVCNickNameView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCNickNameView.h"

@implementation SVCNickNameView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.close.clipsToBounds = YES;
    self.close.layer.cornerRadius = 5;
    self.commit.clipsToBounds = YES;
    self.commit.layer.cornerRadius = 5;
    
    self.textView.clipsToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = Color(235, 236, 237).CGColor;
    self.textView.layer.borderWidth = 1;
}

@end
