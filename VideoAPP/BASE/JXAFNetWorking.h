//
//  JXAFNetWorking.h
//  webSnifferLW
//
//  Created admso on 2017/6/13.
//
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#import "JXRequestModel.h"

// afn
#import "AFNetworking.h"

typedef void(^AFFinishedBlock)(JXRequestModel* obj);
typedef void(^AFFailedBlock)(JXRequestModel* obj);

typedef void(^AFNFinishedBlock)(NSURLSessionDataTask *  task, id   responseObject);
typedef void(^AFNFailedBlock)(NSURLSessionDataTask *  task, NSError *  error);

@interface JXAFNetWorking : NSObject

+(AFHTTPSessionManager*)method:(NSString*)method parameters:(NSDictionary *)parameters finished:(AFFinishedBlock)finishedBlock failed:(AFFailedBlock)failedBlock;

+(AFHTTPSessionManager*)get:(NSString*)method parameters:(NSDictionary *)parameters finished:(AFFinishedBlock)finishedBlock failed:(AFFailedBlock)failedBlock;

@end
