//
//  VDUploadVideoListModel.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDUploadVideoListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id; // ": 75,
@property (nonatomic, strong) NSString<Optional> *title; // ": "发布一个作品测试看看",
@property (nonatomic, strong) NSString<Optional> *brief; // ": "",
@property (nonatomic, strong) NSString<Optional> *image; // ":
@property (nonatomic, strong) NSString<Optional> *is_deleted; //": 0,
@property (nonatomic, strong) NSString<Optional> *status; //": "已发布",
@property (nonatomic, strong) NSString<Optional> *isedit; //": 0

@end

NS_ASSUME_NONNULL_END
