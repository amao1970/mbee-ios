//
//  SVCVideoTableViewCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/11/22.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"
#import "SVCVideoDetailModel.h"
#import "SVCHomePageModel.h"
#import "SVCMoviePlayerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCVideoTableViewCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UIView *maskView;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *attributeLab;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *score;


-(float)setUpVideoModel:(SVCVideoDetailModel*)model;
-(float)setUpHomePageModel:(SVCHomePageModel*)model;
-(float)setUpMovieModel:(SVCMoviePlayerModel*)model;
@end

NS_ASSUME_NONNULL_END
