//
//  VDAtentionModel.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDAtentionModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *nickname; //": "小管",
@property (nonatomic, strong) NSString<Optional> *visit; //": 0,
@property (nonatomic, strong) NSString<Optional> *avatar; //": "http://tp5.starapp.cc/uploads/avatar/20190316/1552668755.jpg",
@property (nonatomic, strong) NSString<Optional> *desc; //": "诚招代理共谋发展，超低成本拿卡a"
@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *vid;

@end

NS_ASSUME_NONNULL_END
