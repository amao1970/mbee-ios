//
//  SVCLiveModel.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLiveModel.h"

@implementation SVCLiveModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SVCLiveModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
