//
//  SVCHomePageModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/6.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVCHomePageModel : NSObject

@property(nonatomic, copy) NSString *ID; /**<<#属性#> */
@property(nonatomic, copy) NSString *type; /**<<#属性#> */
@property(nonatomic, copy) NSString *imgurl; /**<<#属性#> */
@property(nonatomic, copy) NSString *title; /**<<#属性#> */
@property(nonatomic, copy) NSString *weburl; /**<<#属性#> */
@property(nonatomic, copy) NSString *nickname; /**<<#属性#> */
@property(nonatomic, copy) NSString *avatar; /**<<#属性#> */
@property(nonatomic, copy) NSString *createtime; /**<<#属性#> */
@property(nonatomic, copy) NSString *imgurls; /**<<#属性#> */
@property(nonatomic, copy) NSString *videourl; /**<<#属性#> */
@property(nonatomic, copy) NSString *link;
@property(nonatomic, copy) NSString *attribute;
@property(nonatomic, copy) NSString *pingtai;

@end

NS_ASSUME_NONNULL_END
