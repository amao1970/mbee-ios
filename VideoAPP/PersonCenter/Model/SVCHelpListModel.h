//
//  SVCHelpListModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCHelpListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *content;
@property (nonatomic, strong) NSString<Optional> *sort;
@property (nonatomic, strong) NSString<Optional> *create_by_id;
@property (nonatomic, strong) NSString<Optional> *createtime;
@property (nonatomic, strong) NSString<Optional> *updatetime;
@property (nonatomic, strong) NSString<Optional> *is_deleted;

@end

NS_ASSUME_NONNULL_END
