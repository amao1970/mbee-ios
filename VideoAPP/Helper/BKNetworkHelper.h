//
//  BKNetworkHelper.h
//  BaiKeLive
//
//  Created by simope on 16/6/12.
//  Copyright © 2016年 simope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger{
    
    StatusUnknown = -1,//未知状态
    StatusNotReachable = 0,//无网状态
    StatusReachableViaWWAN = 1,//手机网络
    StatusReachableViaWiFi = 2,//Wifi网络
    
} NetworkStatus;

/**
 *  请求\下载进度
 *
 *  @param downloadProgress 总大小值
 *  @param currentValue     计算后的当前进度值
 */
typedef void (^DownloadProgress)(NSProgress *downloadProgress, double currentValue);

/**
 *  请求成功
 */
typedef void (^Success)(id success);

/**
 *  请求失败
 */
typedef void (^Failure)(NSError *failure);

/**
 *  请求结果
 */
typedef void (^RequestResult)(Success,Failure);


@interface BKNetworkHelper : NSObject

@property (nonatomic, assign) NetworkStatus netStatus;
@property (nonatomic, strong) NSOutputStream *outputStream;

/**取消所有网络请求*/
+ (void)cancelAllOperations;


/**
 *  建立网络请求单例
 */
+ (id)shareInstance;

/**
 *  GET请求,设置固定的请求头
 *
 *  @param url              请求接口
 *  @param value            values
 *  @param HTTPHeaderField  key
 *  @param parameters       向服务器请求时的参数
 *  @param success          请求成功，block的参数为服务返回的数据
 *  @param failure          请求失败，block的参数为错误信息
 */
- (void)GET:(NSString *)url
      value:(NSString *)value
HTTPHeaderField:(NSString *)HTTPHeaderField
 Parameters:(NSDictionary *)parameters
    Success:(void (^)(id result))success
    Failure:(void (^)(NSError *error))failure;

/**
 *  GET请求
 *
 *  @param url        请求接口
 *  @param parameters 向服务器请求时的参数
 *  @param success    请求成功，block的参数为服务返回的数据
 *  @param failure    请求失败，block的参数为错误信息
 */
- (void)GET:(NSString *)url
 Parameters:(NSDictionary *)parameters
    Success:(void(^)(id responseObject))success
    Failure:(void (^)(NSError *error))failure;


/**
 *  GET请求,带有进度值
 *
 *  @param url        请求接口
 *  @param parameters 请求参数
 *  @param progress   请求/下载进度值：
 *  @param success    请求成功，block的参数为服务返回的数据
 *  @param failure    请求失败，block的参数为错误信息
 */
- (void)GET:(NSString *)url
 Parameters:(NSDictionary *)parameters
   Progress:(DownloadProgress)progress
    Success:(Success)success
    Failure:(Failure)failure;


/**
 *  POST请求
 *
 *  @param url        要提交的数据结构
 *  @param parameters 要提交的数据
 *  @param success    成功执行，block的参数为服务器返回的内容
 *  @param failure    执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
  Parameters:(NSDictionary *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;

/**
 *  向服务器上传文件
 *
 *  @param url       要上传的文件接口
 *  @param parameter 上传的参数
 *  @param fileData  上传的文件\数据
 *  @param FieldName 服务对应的字段
 *  @param fileName  上传到时服务器的文件名
 *  @param mimeType  上传的文件类型
 *  @param success   成功执行，block的参数为服务器返回的内容
 *  @param failure   执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData
   FieldName:(NSString *)fieldName
    FileName:(NSString *)fileName
    MimeType:(NSString *)mimeType
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;



/**
 *  下载文件
 *
 *  @param url            下载地址
 *  @param PathDirectory  保存位置
 *  @param complete       下载结束：成功返回文件路径
 *  @param progress       设置进度条的百分比：progressValue
 */
- (void)downloadFileWithRequestUrl:(NSString *)url
                          FileName:(NSString *)fileName
                          Complete:(void (^)(NSURL *filePath, NSError *error))complete
                          Progress:(void (^)(id downloadProgress, double currentValue))progress;


/**
 *  下载文件
 *
 *  @param url       下载地址
 *  @param patameter 下载参数
 *  @param savedPath 保存路径
 *  @param complete  下载成功返回文件：NSData
 *  @param progress  设置进度条的百分比：progressValue
 */
- (void)downloadFileWithRequestUrl:(NSString *)url
                         Parameter:(NSDictionary *)patameter
                         SavedPath:(NSString *)savedPath
                          Complete:(void (^)(NSData *data, NSURL *filePath, NSError *error))complete
                          Progress:(void (^)(id downloadProgress, double currentValue))progress;


/**
 *  NSData上传文件
 *
 *  @param str        目标地址
 *  @param fromData   文件源
 *  @param progress   实时进度回调
 *  @param completion 完成结果
 */
- (void)updataDataWithRequestStr:(NSString *)str
                        FromData:(NSData *)fromData
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion;


/**
 *  NSURL上传文件
 *
 *  @param str        目标地址
 *  @param fromUrl    文件源
 *  @param progress   实时进度回调
 *  @param completion 完成结果
 */
- (void)updataFileWithRequestStr:(NSString *)str
                        FromFile:(NSURL *)fromUrl
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion;

/**
 *   监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void(^)(NetworkStatus status))result;

@end
