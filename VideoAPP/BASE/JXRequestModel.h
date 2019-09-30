//
//  HMRequestModel.h
//  Hemefin_iOS
//
//  Created by admso on 2017/9/22.
//  Copyright © 2017年 Hemefin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JXRequestModel.h"
#import "JXJSONModel.h"

@interface JXRequestModel : JXJSONModel

@property (nonatomic, strong) NSString<Optional> *code;
@property (nonatomic, strong) NSString<Optional> *msg;
@property (nonatomic, strong) id<Optional> data;
@property (nonatomic, strong) NSError<Optional> * error;

//得到结果的字典
- (NSDictionary *)getResultDictionary;

//得到结果数组
- (NSArray *)getResultArray;

//得到结果字符串
- (NSString *)getResultString;

@end
