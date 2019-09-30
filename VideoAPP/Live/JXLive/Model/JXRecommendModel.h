//
//  JXRecommendModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXRecommendModel : NSObject

@property (nonatomic,copy) NSString *address;//地址
@property (nonatomic,copy) NSString *title;//名称
@property (nonatomic,copy) NSString *img;//图片
@property (nonatomic,assign) CGSize imageSize;

@end

NS_ASSUME_NONNULL_END
