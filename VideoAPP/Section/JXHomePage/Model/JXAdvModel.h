//
//  JXAdvModel.h
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXJSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXAdvModel : JXJSONModel

@property (nonatomic, strong) NSString<Optional> *type; //": "广告",
@property (nonatomic, strong) NSString<Optional> *title; //": "广告",
@property (nonatomic, strong) NSString<Optional> *image; //": "http://demo.starapp.cc",
@property (nonatomic, strong) NSString<Optional> *url; //": "http://www.baidu.com"
@property (nonatomic, strong) NSString<Optional> *imageURL;

@end

NS_ASSUME_NONNULL_END
