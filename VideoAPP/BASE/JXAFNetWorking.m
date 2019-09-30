//
//  JXAFNetWorking.m
//  webSnifferLW
//
//  Created admso on 2017/6/13.
//
//

#import "JXAFNetWorking.h"
#import "AFNetworking.h"


static float requestSerializerTimeoutInterval = 120.f;
static float SVProgressHUDDismissTime = 0.5f;
static float timerCancel = 2.5f;

@implementation JXAFNetWorking

+ (void)initialize{
}

// -------------------------  封装系统请求
+(AFHTTPSessionManager*)method:(NSString*)method parameters:(NSDictionary *)parameters finished:(AFFinishedBlock)finishedBlock failed:(AFFailedBlock)failedBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = requestSerializerTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud valueForKey:@"token"];
    if (token.length > 2) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    NSString *url = BASE_API;
    url = [NSString stringWithFormat:@"%@%@",url,method];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JXRequestModel *requestModel = [[JXRequestModel alloc] initWithData:responseObject error:nil];
        [SVProgressHUD dismissWithDelay:SVProgressHUDDismissTime];
        if (requestModel.code.integerValue == 0) {
            if ([method isEqualToString:@"/mobile/user/apply"] ||
                [method isEqualToString:@"/mobile/user/addVideo"] ||
                [method isEqualToString:@"/mobile/video/ulike"] ||
                [method isEqualToString:@"/mobile/video/tlike"]) {
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"rechargesuccess" object:nil];
            }
            dispatch_main_after(0.1f, ^{
                [SVProgressHUD dismiss];
            });
            finishedBlock(requestModel);
        }
        
        else if ([requestModel.code isEqualToString:@"-997"]) {
            [SVCCurrUser deledateToken:@"1"];
            [SVCUserInfoUtil deleteFile];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fail" object:nil];
            failedBlock(requestModel);
        }
        
        else{
            dispatch_main_after(0.1f, ^{
                [SVProgressHUD dismiss];
            });
            [[UIApplication sharedApplication].keyWindow.rootViewController.view hideToasts];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:requestModel.msg.length ? requestModel.msg : @""
                                                                                  duration:3.0f position:CSToastPositionCenter];
            failedBlock(requestModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismissWithDelay:SVProgressHUDDismissTime];
        
        JXRequestModel *requestModel = [[JXRequestModel alloc] init];
        requestModel.error = error;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view hideToasts];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:requestModel.msg.length ? requestModel.msg : @""
                                                                              duration:3.0f position:CSToastPositionCenter];
        failedBlock(requestModel);
    }];
    return manager;
}

static void dispatch_main_after(NSTimeInterval delay, void (^block)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

+(AFHTTPSessionManager*)get:(NSString*)method parameters:(NSDictionary *)parameters finished:(AFFinishedBlock)finishedBlock failed:(AFFailedBlock)failedBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = requestSerializerTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud valueForKey:@"token"];
    if (token.length > 2) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    NSString *url = BASE_API;
    url = [NSString stringWithFormat:@"%@/%@",url,method];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JXRequestModel *requestModel = [[JXRequestModel alloc] initWithData:responseObject error:nil];
        [SVProgressHUD dismissWithDelay:SVProgressHUDDismissTime];
        if (requestModel.code.integerValue == 0) {
            dispatch_main_after(0.1f, ^{
                [SVProgressHUD dismiss];
            });
            finishedBlock(requestModel);
        }
        
        else if ([requestModel.code isEqualToString:@"-997"]) {
            [SVCCurrUser deledateToken:@"1"];
            [SVCUserInfoUtil deleteFile];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fail" object:nil];
            failedBlock(requestModel);
        }
        
        else{
            
            dispatch_main_after(0.1f, ^{
                [SVProgressHUD dismiss];
            });
            if (![method isEqualToString:@"/mobile/user/apply"]) {
                [[UIApplication sharedApplication].keyWindow.rootViewController.view hideToasts];
                [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:requestModel.msg.length ? requestModel.msg : @""
                                                                                      duration:3.0f position:CSToastPositionCenter];
            }
            
            failedBlock(requestModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismissWithDelay:SVProgressHUDDismissTime];
        
        JXRequestModel *requestModel = [[JXRequestModel alloc] init];
        requestModel.error = error;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view hideToasts];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:requestModel.msg.length ? requestModel.msg : @""
                                                                              duration:3.0f position:CSToastPositionCenter];
        failedBlock(requestModel);
    }];
    return manager;
    
}

@end
