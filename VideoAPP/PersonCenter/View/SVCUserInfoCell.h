//
//  SVCUserInfoCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCUserInfoCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIImageView *right;

@end

NS_ASSUME_NONNULL_END
