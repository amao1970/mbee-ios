//
//  JXAdvCell.h
//  MovieApp
//
//  Created by admxjx on 2019/4/22.
//

#import "JXCollectionViewCell.h"
#import "JXAdvModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXAdvCell : JXCollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) JXAdvModel *model;

@end

NS_ASSUME_NONNULL_END
