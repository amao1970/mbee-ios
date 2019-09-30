//
//  JXPlayBackModel.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXPlayBackModel.h"

@implementation JXPlayBackModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"imageSize"])
        return YES;
    
    return NO;
}
@end
