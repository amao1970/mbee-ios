//
//  JXVideoInfoModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXVideoInfoModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *cate_id;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *image;
@property (nonatomic, strong) NSString<Optional> *sort;
@property (nonatomic, strong) NSString<Optional> *createtime;
@property (nonatomic, strong) NSString<Optional> *tui;
@property (nonatomic, strong) NSString<Optional> *click;
@property (nonatomic, strong) NSString<Optional> *attribute;
@property (nonatomic, strong) NSString<Optional> *link;
@property (nonatomic, strong) NSArray<Optional> *tag;
@property (nonatomic, strong) NSString<Optional> *brief;
@property (nonatomic, strong) NSString<Optional> *sc;
@property (nonatomic, strong) NSString<Optional> *authornick;
@property (nonatomic, strong) NSString<Optional> *authoravatar;
@property (nonatomic, strong) NSString<Optional> *authorid;

@end

NS_ASSUME_NONNULL_END
