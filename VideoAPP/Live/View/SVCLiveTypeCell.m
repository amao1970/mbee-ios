//
//  SVCLiveTypeCell.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLiveTypeCell.h"
#import "SVCLiveModel.h"
#import <UIImageView+AFNetworking.h>
#import "NSString+Extension.h"
@implementation SVCLiveTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numButton.layer.cornerRadius = 7.0;
    self.numButton.layer.masksToBounds = YES;
    NSInteger num = rand()%500+500;
    [self.numButton setTitle:[NSString stringWithFormat:@"%ld",num] forState:UIControlStateNormal];
    // Initialization code
}
-(void)setLiveModel:(SVCLiveModel *)liveModel{
    _liveModel = liveModel;
    self.liveTitle.text = [NSString stringWithFormat:@"  %@",liveModel.title];
    
    NSArray *arr = [liveModel.img componentsSeparatedByString:@"?"];

    self.imageViewICon.contentMode = UIViewContentModeScaleAspectFill;
  [self.imageViewICon sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
}



@end
