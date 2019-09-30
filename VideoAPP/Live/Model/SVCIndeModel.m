//
//  SVCIndeModel.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCIndeModel.h"

@implementation SVCIndeModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SVCIndeModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
