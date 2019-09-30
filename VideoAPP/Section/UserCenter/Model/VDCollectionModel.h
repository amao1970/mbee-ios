//
//  VDCollectionModel.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDCollectionModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id; //": 67,
@property (nonatomic, strong) NSString<Optional> *title; //":
@property (nonatomic, strong) NSString<Optional> *image; //": "
@property (nonatomic, strong) NSString<Optional> *brief; //": ""

@end

NS_ASSUME_NONNULL_END
