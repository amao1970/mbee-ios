//
//  SVCAllLiveCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCAllLiveCell : JXCollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UIView *imgMaskView;

@end

NS_ASSUME_NONNULL_END
