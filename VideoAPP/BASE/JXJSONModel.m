//
//  JXJSONModel.m
//  webSnifferLW
//
//  Created by admso on 2018/8/9.
//

#import "JXJSONModel.h"

@implementation JXJSONModel

+(instancetype)modelFromeDic:(NSDictionary*)dic
{
    return  [[[self class] alloc] initWithDictionary:dic error:nil];
}

+(NSMutableArray*)arrayOfModelsFromDictionaries:(NSArray*)dicAry
{
    return [[self class] arrayOfModelsFromDictionaries:dicAry error:nil];
}

-(NSDecimalNumber*)accuracy:(double)number
{
    NSString *doubleString = [NSString stringWithFormat:@"%lf", number];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber;
}

@end
