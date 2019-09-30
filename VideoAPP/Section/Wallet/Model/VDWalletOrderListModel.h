//
//  VDWalletOrderListModel.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDWalletOrderListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id ;// ": 2,
@property (nonatomic, strong) NSString<Optional> *uid;//: 1,
@property (nonatomic, strong) NSString<Optional> *type;//": 3,
@property (nonatomic, strong) NSString<Optional> *money;//": "12",
@property (nonatomic, strong) NSString<Optional> *pid;//": "wxpay",
@property (nonatomic, strong) NSString<Optional> *status;//": "结算中",
@property (nonatomic, strong) NSString<Optional> *createtime;//": "1970-01-01 08:00:00",
@property (nonatomic, strong) NSString<Optional> *updatetime;//": 1557626205,
@property (nonatomic, strong) NSString<Optional> *adminid;//": 1,
@property (nonatomic, strong) NSString<Optional> *content;//": "拒绝理由"

@end

NS_ASSUME_NONNULL_END
