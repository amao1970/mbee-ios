//
//  JXPlayBackCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXPlayBackCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
@property (strong, nonatomic) IBOutlet UIButton *but;
@property (strong, nonatomic) IBOutlet UIView *line;


@end

NS_ASSUME_NONNULL_END
