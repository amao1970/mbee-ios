//
//  JXKindCell.h
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXCollectionViewCell.h"
#import "JXKindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXKindCell : JXCollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) JXKindModel* model;

@end

NS_ASSUME_NONNULL_END
