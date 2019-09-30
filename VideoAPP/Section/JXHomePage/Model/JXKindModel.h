//
//  JXKindModel.h
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXJSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXKindModel : JXJSONModel


@property (nonatomic, strong) NSString<Optional> *id; // ": 1,
@property (nonatomic, strong) NSString<Optional> *title; // ": "无码",
@property (nonatomic, strong) NSString<Optional> *is_show; // ": 1,
@property (nonatomic, strong) NSString<Optional> *sort; // ": 1,
@property (nonatomic, strong) NSString<Optional> *create_by_id; // ": 1,
@property (nonatomic, strong) NSString<Optional> *createtime; // ": 1541992474,
@property (nonatomic, strong) NSString<Optional> *updatetime; // ": 1554904440,
@property (nonatomic, strong) NSString<Optional> *is_deleted; // ": 0,
@property (nonatomic, strong) NSString<Optional> *icon; // ": "http://demo.starapp.cc"

@end

NS_ASSUME_NONNULL_END
