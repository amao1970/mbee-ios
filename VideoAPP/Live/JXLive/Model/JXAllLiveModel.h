//
//  JXAllLiveModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXAllLiveModel : JSONModel

@property (nonatomic,copy) NSString<Optional> *address;//地址
@property (nonatomic,copy) NSString<Optional> *title;//名称
@property (nonatomic,copy) NSString<Optional> *img;//图片
@property (nonatomic,assign) CGSize imageSize;

@end

NS_ASSUME_NONNULL_END
