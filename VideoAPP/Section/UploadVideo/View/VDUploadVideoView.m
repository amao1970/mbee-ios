//
//  VDUploadVideoView.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDUploadVideoView.h"

@implementation VDUploadVideoView

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.commit.layer.cornerRadius = 8;
    self.uploadVideo.layer.cornerRadius = 3;
    self.descLab.layer.borderWidth = 0.5;
    self.descLab.layer.borderColor = [UIColor hexStringToColor:@"a7a7a7"].CGColor;
    self.descLab.layer.cornerRadius = 5;
}

@end
