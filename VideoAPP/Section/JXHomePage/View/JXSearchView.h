//
//  JXSearchView.h
//  MovieApp
//
//  Created by admxjx on 2019/4/26.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXSearchView : JXView

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UIButton *uploadBtn;
@property (strong, nonatomic) IBOutlet UIButton *collection;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;

@end

NS_ASSUME_NONNULL_END
