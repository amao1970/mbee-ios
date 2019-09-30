//
//  JXRecommendCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"
#import "JXRecommendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXRecommendCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *fansLab;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *audienceLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *bgView1;
@property (strong, nonatomic) IBOutlet UIView *bgView2;
-(void)reloadWithModel:(JXRecommendModel*)model;

@end

NS_ASSUME_NONNULL_END
