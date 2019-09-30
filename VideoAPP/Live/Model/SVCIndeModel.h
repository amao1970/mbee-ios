//
//  SVCIndeModel.h
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVCIndeModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *is_show;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
