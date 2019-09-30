//
//  NSString+Others.h
//  WaterCommunity
//
//  Created by 雷文霄 on 2017/2/6.
//  Copyright © 2017年 hxisWater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Others)
+(NSString *)ret32bitString;
+(NSString *)md5HexDigest:(NSString*)input;
+(NSString *)getTimeInterval;

+(NSString *)getIpAddresses;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSString*)dataToJSONString:(id)object;

@end
