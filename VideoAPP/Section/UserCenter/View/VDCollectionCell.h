//
//  VDCollectionCell.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VDCollectionCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *desc;

@end

NS_ASSUME_NONNULL_END