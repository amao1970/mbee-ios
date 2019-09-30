//
//  SVCMoviePlayerModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/25.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCMoviePlayerModel : JSONModel

@property(nonatomic, copy) NSString *id; /**<<#属性#> */
@property(nonatomic, copy) NSString *title; /**<<#属性#> */
@property(nonatomic, copy) NSString *cate; /**<<#属性#> */
@property(nonatomic, copy) NSString *image; /**<<#属性#> */
@property(nonatomic, copy) NSString *link; /**<<#属性#> */
@property(nonatomic, copy) NSString *create_by_id; /**<<#属性#> */
@property(nonatomic, copy) NSString *createtime; /**<<#属性#> */
@property(nonatomic, copy) NSString *tui; /**<<#属性#> */
@property(nonatomic, copy) NSString *avatar; /**<<#属性#> */
@property(nonatomic, copy) NSString *nickname; /**<<#属性#> */
@property(nonatomic, copy) NSString *type; /**<<#属性#> */
@property(nonatomic, copy) NSString *attribute;
@property(nonatomic, copy) NSString *pingtai;
@property(nonatomic, copy) NSString *score;
@property(nonatomic, copy) NSString *tag;
@property(nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
