//
//  BKNetworkHelper.m
//  BaiKeLive
//
//  Created by simope on 16/6/12.
//  Copyright © 2016年 simope. All rights reserved.
//

#import "BKNetworkHelper.h"
#import "AFNetworking.h"
#import "MBProgressHUD+BK.h"

static NSString * const kAFNetworkingLockName = @"com.alamofire.networking.operation.lock";

@interface BKNetworkHelper ()

@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation BKNetworkHelper
@synthesize outputStream = _outputStream;

+(void)cancelAllOperations{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

/**
 *  建立网络请求单例
 */
+ (id)shareInstance{
    static BKNetworkHelper *helper;
    static dispatch_once_t onceToken;
    
    __weak BKNetworkHelper *weakSelf = helper;
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[BKNetworkHelper alloc]init];
            weakSelf.lock = [[NSRecursiveLock alloc] init];
            weakSelf.lock.name = kAFNetworkingLockName;
        }
    });
    return helper;
}

/**
 *  GET请求,设置固定的请求头
 */
- (void)GET:(NSString *)url
      value:(NSString *)value
HTTPHeaderField:(NSString *)HTTPHeaderField
 Parameters:(NSDictionary *)parameters
    Success:(void (^)(id result))success
    Failure:(void (^)(NSError *error))failure{
    //断言
    NSAssert(url != nil, @"url不能为空");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    //使用AFNetworking进行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //因为服务器返回的数据如果不是application/json格式的数据
    //需要以NSData的方式接收,然后自行解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:value forHTTPHeaderField:HTTPHeaderField];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    //发起get请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //将返回的数据转成json数据格式
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        //通过block，将数据回掉给用户
        if (success) success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}


/**
 *  GET请求
 */
- (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure{

    //网络检查
    [BKNetworkHelper checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
//            [MBProgressHUD showOnlyTextToView:@"网络连接失败！" ToView:kWindow];
            return;
        }
    }];
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    //使用AFNetworking进行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //因为服务器返回的数据如果不是application/json格式的数据
    //需要以NSData的方式接收,然后自行解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    //发起get请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //将返回的数据转成json数据格式
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        //通过block，将数据回掉给用户
        if (success) success(result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}


/**
 *  GET请求,带有进度值
 */
- (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Progress:(DownloadProgress)progress Success:(Success)success Failure:(Failure)failure{
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    //使用AFNetworking进行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //服务器返回的数据如果不是application/json格式的数据
    //需要以NSData的方式接收,然后自行解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //超时设置
    manager.requestSerializer.timeoutInterval = 10;
    
    //发起get请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        double progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        if (progress) progress(downloadProgress, progressValue);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //将返回的数据转成json数据格式
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        //通过block，将数据回掉给用户
        if (success) success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}


/**
 *  POST请求
 */
- (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure{
    
    //网络检查
    [BKNetworkHelper checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
//            [MBProgressHUD showOnlyTextToView:@"网络连接失败！" ToView:kWindow];
            return;
        }
    }];
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud valueForKey:@"token"];
    
    if (token.length > 2) {
       [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"我的token %@",token);
        //将返回的数据转成json数据格式
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        NSString *codeNum = [NSString stringWithFormat:@"%@",result[@"code"]];
        if ([codeNum isEqualToString:@"-997"]) {
            [SVCCurrUser deledateToken:@"1"];
            [SVCUserInfoUtil deleteFile];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fail" object:nil];
        }
        //通过block，将数据回掉给用户
        if (success) success(result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

//        NSString *errorString = error.userInfo[@"NSLocalizedDescription"];
//        [MBProgressHUD showOnlyTextToView:errorString ToView:kWindow];
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}


///**
// *  向服务器上传文件
// */
//- (void)POST:(NSString *)url
//   Parameter:(NSDictionary *)parameter
//        Data:(NSData *)fileData FieldName:(NSString *)fieldName
//    FileName:(NSString *)fileName MimeType:(NSString *)mimeType
//     Success:(void (^)(id))success
//     Failure:(void (^)(NSError *))failure{
//    //网络检查
//    [BKNetworkHelper checkingNetworkResult:^(NetworkStatus status) {
//        if (status == StatusNotReachable) {
//            [MBProgressHUD showOnlyTextToView:@"网络连接失败！" ToView:kWindow];
//            return;
//        }
//    }];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 10;
//
//    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFileData:fileData name:fieldName fileName:fileName mimeType:mimeType];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//
//        //将返回的数据转成json数据格式
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
//
//        //将返回的数据转成json数据格式
//       if (success) success(result);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//
//        //通过block,将错误信息回传给用户
//       if (failure) failure(error);
//    }];
//}

/**
 *  下载文件
 */
- (void)downloadFileWithRequestUrl:(NSString *)url
                          FileName:(NSString *)fileName
                          Complete:(void (^)(NSURL *filePath, NSError *error))complete
                          Progress:(void (^)(id downloadProgress, double currentValue))progress{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        double progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        if (progress) {
            progress(downloadProgress,progressValue);
        }
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", cachesPath, [url lastPathComponent]];
//        NSString *path = [fullPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (complete) {
            complete(filePath,error);
        }
    }];
    [downloadTask resume];
}




/**
 *  下载文件
 */
//- (void)downloadFileWithRequestUrl:(NSString *)url
//                         Parameter:(NSDictionary *)patameter
//                         SavedPath:(NSString *)savedPath
//                          Complete:(void (^)(NSData *data, NSURL *filePath, NSError *error))complete
//                          Progress:(void (^)(id downloadProgress, double currentValue))progress{
//    //网络检查
//    [BKNetworkHelper checkingNetworkResult:^(NetworkStatus status) {
//        if (status == StatusNotReachable) {
//            [MBProgressHUD showOnlyTextToView:@"网络连接失败！" ToView:kWindow];
//            return;
//        }
//    }];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//
//    //默认配置
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//
//    //AFN3.0URLSession的句柄
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    //下载Task操作
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//        double progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
//       if (progress) progress(downloadProgress, progressValue);
//
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
////        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
////        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//
//
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//
//        return documentsDirectoryURL;
////        return [NSURL fileURLWithPath:savedPath != nil ? savedPath : path];
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//
//        // filePath就是下载文件的位置，可以直接拿来使用
//        NSData *data;
//        if (!error) {
//            data = [NSData dataWithContentsOfURL:filePath];
//            NSLog(@"下载地址:%@",filePath);
//        }
//        if (complete) complete(data, filePath,error);
//    }];
//
//    //默认下载操作是挂起的，须先手动恢复下载。
//    [downloadTask resume];
//}
//
//
///**
// *  NSData上传文件
// */
//- (void)updataDataWithRequestStr:(NSString *)str
//                        FromData:(NSData *)fromData
//                        Progress:(void(^)(NSProgress *uploadProgress))progress
//                      Completion:(void(^)(id object,NSError *error))completion{
//
//    NSURL *url = [NSURL URLWithString:str];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    [manager uploadTaskWithRequest:request fromData:fromData progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        if (progress) progress(uploadProgress);
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        if (completion) completion(responseObject,error);
//    }];
//}


/**
 *  NSURL上传文件
 */
- (void)updataFileWithRequestStr:(NSString *)str
                        FromFile:(NSURL *)fromUrl
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion{
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromFile:fromUrl progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (completion) completion(responseObject,error);
    }];
}


/**
 *   监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void (^)(NetworkStatus))result {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        if (status == AFNetworkReachabilityStatusUnknown) {
            
            if (result) result(StatusUnknown);
            
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            
            if (result) result(StatusNotReachable);
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            
            if (result) result(StatusReachableViaWWAN);
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
            if (result) result(StatusReachableViaWiFi);
            
        }
    }];
}


/**
 *   取消所有正在执行的网络请求项
 */
- (void)cancelAllNetworkingRequest{

    //开发中...
}


- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        self.outputStream = [NSOutputStream outputStreamToMemory];
    }
    
    return _outputStream;
}


- (void)setOutputStream:(NSOutputStream *)outputStream {
    [self.lock lock];
    if (outputStream != _outputStream) {
        if (_outputStream) {
            [_outputStream close];
        }
        _outputStream = outputStream;
    }
    [self.lock unlock];
}


- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix{
    NSString    *result;
    NSString    *newResult;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    newResult = [NSString stringWithFormat:@"%@",uuidStr];
    NSLog(@"-----%@----",newResult);
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

@end
