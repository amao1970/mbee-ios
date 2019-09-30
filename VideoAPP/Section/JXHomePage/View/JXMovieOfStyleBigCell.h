//
//  JXMovieOfStyleBigCell.h
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXCollectionViewCell.h"
#import "JXProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXMovieOfStyleBigCell : JXCollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) JXProductModel* model;


@end

NS_ASSUME_NONNULL_END
