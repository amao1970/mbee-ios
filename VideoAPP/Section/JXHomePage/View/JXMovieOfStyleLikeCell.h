//
//  JXMovieOfStyleLikeCell.h
//  MovieApp
//
//  Created by admxjx on 2019/4/22.
//

#import "JXCollectionViewCell.h"
#import "JXProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXMovieOfStyleLikeCell : JXCollectionViewCell

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic, strong) NSMutableArray *list;

@end

NS_ASSUME_NONNULL_END
