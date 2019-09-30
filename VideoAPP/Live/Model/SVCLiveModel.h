//
//  SVCLiveModel.h
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVCLiveModel : NSObject

@property (nonatomic,copy) NSString *name;//标识
@property (nonatomic,copy) NSString *title;//名称
@property (nonatomic,copy) NSString *img;//图片
@property (nonatomic, copy)NSString *number;//直播间数
@property (nonatomic, copy)NSString *is_badge;//弹幕显示（1显示 0 隐藏）
@property (nonatomic, copy)NSString *play_url;//弹幕显示（1显示 0 隐藏）

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
