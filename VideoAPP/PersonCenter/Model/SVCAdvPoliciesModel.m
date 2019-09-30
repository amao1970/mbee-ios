//
//  SVCAdvPoliciesModel.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/5.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCAdvPoliciesModel.h"

@implementation SVCAdvPoliciesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",
             @"content":@"contact"
             };
}
@end
