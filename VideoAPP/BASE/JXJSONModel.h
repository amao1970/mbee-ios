//
//  JXJSONModel.h
//  webSnifferLW
//
//  Created by admso on 2018/8/9.
//

#import <JSONModel/JSONModel.h>

@interface JXJSONModel : JSONModel

// 返回对象
+(instancetype)modelFromeDic:(NSDictionary*)dic;
// 返回数组
+(NSMutableArray*)arrayOfModelsFromDictionaries:(NSArray*)dicAry;

-(NSDecimalNumber*)accuracy:(double)number;

@end
