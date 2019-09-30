//
//  SVCTVAreaModel.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTVAreaModel.h"
#import "MJExtension.h"

@implementation SVCTVAreaModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"SVCTVLiveModel"};
}
@end
