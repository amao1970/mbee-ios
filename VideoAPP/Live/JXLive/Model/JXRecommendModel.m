//
//  JXRecommendModel.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXRecommendModel.h"

@implementation JXRecommendModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"imageSize"])
        return YES;
    
    return NO;
}

@end
