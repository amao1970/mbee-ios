//
//  HMRequestModel.m
//  Hemefin_iOS
//
//  Created by admso on 2017/9/22.
//  Copyright © 2017年 Hemefin. All rights reserved.
//

#import "JXRequestModel.h"

@implementation JXRequestModel

//得到结果的字典
- (NSDictionary *)getResultDictionary{
    return (NSDictionary*)self.data;
}

//得到结果数组
- (NSArray *)getResultArray{
    return (NSArray*)self.data;
}

//得到结果字符串
- (NSString *)getResultString{
    return (NSString*)self.data;
}


@end
