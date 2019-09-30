//
//  VDWalletDetailListModel.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDWalletDetailListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id; //": 1,
@property (nonatomic, strong) NSString<Optional> *uid; //": 1,
@property (nonatomic, strong) NSString<Optional> *type; //": 1,
@property (nonatomic, strong) NSString<Optional> *money; //": "15",
@property (nonatomic, strong) NSString<Optional> *createtime; //": "2019-05-02 10:17:33",
@property (nonatomic, strong) NSString<Optional> *title; //": "一步一步教您跳《健身操》还有背面跟着跳，轻松减肥"

@end

NS_ASSUME_NONNULL_END
