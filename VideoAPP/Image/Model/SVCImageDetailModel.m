//
//  SVCImageDetailModel.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/4.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCImageDetailModel.h"

@implementation SVCImageDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",
             @"create_by_ID":@"create_by_id"
             };
    
}
@end
