//
//  SVCMovieDetailCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXCollectionViewCell.h"
#import "SVCMoviePlayerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCMovieDetailCell : JXCollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *attributeLab;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;

-(void)setUpMovieModel:(SVCMoviePlayerModel*)model;

@end

NS_ASSUME_NONNULL_END
