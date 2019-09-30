//
//  VDUploadVideoVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//
#import <Photos/Photos.h>
#import "VDUploadVideoVC.h"
#import "VDUploadVideoView.h"
#import <AVFoundation/AVFoundation.h>

#import "JXVideoInfoModel.h"
#import "VDUploadVideoListVC.h"
#import <SDWebImage/UIButton+WebCache.h>

//获取当前顶部视图
#define TOPCONTROLLER ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController ? [UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController : [UIApplication sharedApplication].keyWindow.rootViewController)

#define GTColor_A2 HEXRGB(0x666666)

#define GTFont_T2 [UIFont systemFontOfSize:GTWordSize_T2]

@interface VDUploadVideoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) VDUploadVideoView *mainView;
@property (nonatomic, strong) UIScrollView *bgView;
@property (nonatomic, strong) NSString *Mp4FilePath;
@property (nonatomic, strong) NSString *videoPath;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSDictionary *videoDic;
@property (nonatomic, strong) UIImage *img;

@property (nonatomic, strong) NSDictionary *videoDataInfo;
@property (nonatomic, strong) NSDictionary *imgDataInfo;

@property (nonatomic, strong) JXVideoInfoModel *videoInfo;

@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation VDUploadVideoVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpMainView];
    if (self.videoID != nil && self.videoID.length > 0) {
        self.title = @"编辑视频";
        [self getVideoInfo];
    }
}

-(void)setUpMainView{
    self.mainView = [VDUploadVideoView getViewFormNSBunld];
    self.mainView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    if (IsIphone5a5c5s) {
        self.mainView.descLab.height = JXHeight(170);
        self.mainView.commit.y = self.mainView.descLab.bottom + JXHeight(10);
    }
    [self.mainView.uploadVideo addTarget:self action:@selector(actionVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.uploadImg addTarget:self action:@selector(LocalPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.commit addTarget:self action:@selector(click_commit) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.videoLab addTarget:self action:@selector(videoLabEdit:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.mainView];
    
    self.bgView = [[UIScrollView alloc] init];
    self.bgView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT - Tabbar_HEIGHT);
    self.bgView.contentSize = CGSizeMake(SCR_WIDTH, SCR_HIGHT);
    self.bgView.delegate = self;
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.mainView];
}

-(void)getVideoInfo{
    [WsHUD showHUDWithLabel:@"正在加载..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking method:@"/mobile/video/infos" parameters:@{@"id": self.videoID} finished:^(JXRequestModel *obj) {
        self.videoInfo = [[JXVideoInfoModel alloc] initWithDictionary:[obj getResultDictionary][@"videoinfo"] error:nil];
        __block NSString *tag = @"";
        [self.videoInfo.tag enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            tag = [tag stringByAppendingFormat:@"%@%@%@",tag,tag.length?@",":@"", obj];
        }];
        self.mainView.titleTF.text = self.videoInfo.title;
        self.mainView.videoLab.text = self.videoInfo.link;
        self.mainView.tagLab.text = tag;
        self.mainView.descLab.text = self.videoInfo.brief;
        self.mainView.imgLab.text = self.videoInfo.image;
        NSURL * url = [NSURL URLWithString:self.videoInfo.image];
        [self.mainView.uploadImg sd_setImageWithURL:url forState:UIControlStateNormal];
//        // 根据图片的url下载图片数据
//        dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
//        dispatch_async(xrQueue, ^{
//            // 异步下载图片
//            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//            // 主线程刷新UI
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.mainView.uploadImg setImage:img forState:UIControlStateNormal];
//            });
//        });

        [WsHUD hideHUD];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];
}

//打开本地相册
-(void)LocalPhoto
{
    // iOS 8.0以上系统
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    NSLog(@"openGallery_authorStatus == %ld",(long)authorStatus);
    if (authorStatus == PHAuthorizationStatusAuthorized ||
        authorStatus == PHAuthorizationStatusNotDetermined){
        //获取权限
        //        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"相机权限不足，设置相机权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
                
            }
        }];
        [alertController addAction:okAction];
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:closeAction];
        [self presentViewController:alertController animated:YES completion:nil];
        ;
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
//    picker.navigationBar.tintColor = [UIColor blackColor];
    [self.tabBarController presentViewController:picker animated:YES completion:^{
//        UIViewController*vc = picker.viewControllers.lastObject;
//        picker.navigationBar.tintColor = [UIColor blackColor];
//        vc.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }];
    TOPCONTROLLER.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    if ([picker.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        
        [picker.navigationBar setTranslucent:YES];
        [picker.navigationBar setTintColor:[UIColor blackColor]];
        
    }
}

- (void)actionVideo {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    NSLog(@"从视频库选择");
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    picker.allowsEditing = NO;
    picker.delegate = self;
//    picker.navigationBar.tintColor = [UIColor blackColor];
    [self.tabBarController presentViewController:picker animated:YES completion:^{
//        UIViewController*vc = picker.viewControllers.lastObject;
//        picker.navigationBar.tintColor = [UIColor blackColor];
//        vc.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }];
    
    TOPCONTROLLER.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    if ([picker.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        
        [picker.navigationBar setTranslucent:YES];
        [picker.navigationBar setTintColor:[UIColor blackColor]];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //判断是不是视频类型
    NSLog(@"%@", info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.movie"] == YES) {
        
        NSString *path = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerMediaURL"]];
        self.videoPath = path;
        self.mainView.videoLab.text = [NSString stringWithFormat:@"%@",path];
        self.videoDic = info;
        [self movFileTransformToMP4WithSourcePath:path];
    }else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        self.imgPath =  [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        //先把图片转成NSData
        self.mainView.imgLab.text = self.imgPath;
        UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        self.img = img;
        [self.mainView.uploadImg setImage:img forState:UIControlStateNormal];
//        [self updateImg:img];
    }
}

// 图片转64base字符串
- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImageJPEGRepresentation(image, 0.2) ;//UIImagePNGRepresentation(image);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}

-(void)updateImg:(UIImage*)img{
    if (self.videoID != nil && self.videoID.length > 0) {
        if (!self.img) {
            [self commitVideoInfo ];
            return;
        }
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud valueForKey:@"token"];
    
    NSDictionary *dic = @{@"token":token?token:@"",
                          @"avatar":[@"data:image/jpeg;base64," stringByAppendingFormat:@"%@",[self imageToString:img]]
                          };
    [WsHUD showHUDWithLabel:@"正在上传图片..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking method:@"/mobile/user/upimage" parameters:dic finished:^(JXRequestModel *obj) {
        NSLog(@"%@",obj);
        self.imgDataInfo = [obj getResultDictionary];
        [self commitVideoInfo];
        [WsHUD hideHUD];
    } failed:^(JXRequestModel *obj) {
        NSLog(@"失败 ——obj %@",obj);
        [WsHUD hideHUD];
    }];
}


//上传图片和视频
- (void)uploadMovie:(NSDictionary *)videoDic Mp4FilePath:(NSString*)Mp4FilePath {
    
    //获取文件的后缀名
    NSString *extension = [Mp4FilePath componentsSeparatedByString:@"."].lastObject;
    
    //设置mimeType
    NSString *mimeType = [NSString stringWithFormat:@"file/%@", extension];
    
    //创建AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置响应文件类型为JSON类型
    manager.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    //初始化requestSerializer
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = nil;
    
    //设置timeout
    [manager.requestSerializer setTimeoutInterval:20.0];
    
    //设置请求头类型
    [manager.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud valueForKey:@"token"];
    if (token.length > 2) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
    //上传服务器接口
    NSString *url = [NSString stringWithFormat:@"%@/mobile/user/upVideo",BASE_API];
    [WsHUD showHUDWithLabel:@"正在上传视频..." modal:NO timeoutDuration:120.0];
    //开始上传
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSError *error;
        BOOL success = [formData appendPartWithFileURL:[NSURL fileURLWithPath:Mp4FilePath] name:@"file" fileName:Mp4FilePath.lastPathComponent mimeType:mimeType error:&error];
        if (!success) {
            
            NSLog(@"appendPartWithFileURL error: %@", error);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传进度: %f", uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.videoDataInfo = responseObject[@"data"];
        [self updateImg:self.img];
        NSLog(@"成功返回: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WsHUD hideHUD];
        [self.view toastShow:@"上传失败"];
        NSLog(@"上传失败: %@", error);
//        model.isUploaded = NO;
    }];
}

-(void)commitVideoInfo{
    NSString *videoURLString = @"";
    if ([self.videoPath isEqualToString:self.mainView.videoLab.text]) {
        videoURLString = [NSString stringWithFormat:@"%@",self.videoDataInfo[@"url"]];
    }else{
        videoURLString = self.mainView.videoLab.text.length ? self.mainView.videoLab.text : @"";
    }
    NSString *imgURLString = @"";
    if ([self.imgPath isEqualToString:self.mainView.imgLab.text]) {
        imgURLString = [NSString stringWithFormat:@"%@",self.imgDataInfo[@"avatar"]];
    }else{
        imgURLString = self.mainView.videoLab.text.length ? self.mainView.videoLab.text : @"";
    }
    NSDictionary *dic = @{@"title":self.mainView.titleTF.text.length ? self.mainView.titleTF.text : @"",
                          @"image":imgURLString,
                          @"link":videoURLString,
                          @"tag":self.mainView.tagLab.text.length ? self.mainView.tagLab.text : @"",
                          @"brief":self.mainView.descLab.text.length ? self.mainView.descLab.text : @"",
                          @"id":@""
                          };
    
    if (self.videoID != nil && self.videoID.length > 0) {
        NSString *videoURL = self.videoDataInfo ? [NSString stringWithFormat:@"%@",self.videoDataInfo[@"url"]] : self.videoInfo.link;
        if ([self.videoPath isEqualToString:self.mainView.videoLab.text]) {
            videoURL = [NSString stringWithFormat:@"%@",self.videoDataInfo[@"url"]];
        }
        else if([self.mainView.videoLab.text isEqualToString:self.videoInfo.link]){
            videoURL =  [NSString stringWithFormat:@"%@",self.videoInfo.link];
        }
        else{
            videoURL = self.mainView.videoLab.text.length ? self.mainView.videoLab.text : @"";
        }
        
        NSString *image = self.imgDataInfo ? [NSString stringWithFormat:@"%@",self.imgDataInfo[@"avatar"]] : self.videoInfo.image;
        if ([self.imgPath isEqualToString:self.mainView.imgLab.text]) {
            image = [NSString stringWithFormat:@"%@",self.imgDataInfo[@"avatar"]];
        }
        else if([self.mainView.imgLab.text isEqualToString:self.videoInfo.image]){
            image =  [NSString stringWithFormat:@"%@",self.videoInfo.image];
        }
        else{
            image = self.mainView.imgLab.text.length ? self.mainView.imgLab.text : @"";
        }
        dic = @{@"title":self.mainView.titleTF.text.length ? self.mainView.titleTF.text : @"",
                @"image":image,
                @"link":videoURL,
                @"tag":self.mainView.tagLab.text.length ? self.mainView.tagLab.text : @"",
                @"brief":self.mainView.descLab.text.length ? self.mainView.descLab.text : @"",
                @"id":self.videoID
                };
    }
    [WsHUD showHUDWithLabel:@"正在上传数据..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking method:@"/mobile/user/addVideo" parameters:dic finished:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        [self.view toastShow:@"上传成功"];
        if (self.videoID != nil && self.videoID.length > 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            self.mainView.titleTF.text = @"";
            self.mainView.tagLab.text = @"";
            self.mainView.descLab.text = @"";
            self.mainView.videoLab.text = @"";
            self.mainView.imgLab.text = @"";
            self.videoDataInfo = nil;
            self.imgDataInfo = nil;
            self.img = nil;
            self.videoDic = nil;
            [self.mainView.uploadImg setTitle:@"+" forState:UIControlStateNormal];
            [self.mainView.uploadVideo setTitle:@"上传" forState:UIControlStateNormal];
            VDUploadVideoListVC* vc = [[VDUploadVideoListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];
}

-(void)updateUI{
    if (self.Mp4FilePath) {
        [self.mainView.uploadVideo setTitle:@"重新上传" forState:UIControlStateNormal];
        self.mainView.videoLab.text = self.videoPath;
    }
}


- (void)movFileTransformToMP4WithSourcePath:(NSString *)sourcePath
{
    /**
     *  mov格式转mp4格式
     */
    NSURL *sourceUrl = [NSURL URLWithString:sourcePath];
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        NSString *fileStr = [[sourcePath componentsSeparatedByString:@"/"].lastObject.uppercaseString stringByRemovingPercentEncoding];
        NSString *fileName = [[fileStr componentsSeparatedByString:@"."].firstObject.uppercaseString stringByRemovingPercentEncoding];
        NSString *uniqueName = [NSString stringWithFormat:@"%@.mp4",fileName];
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = docPaths.lastObject;
        NSString * resultPath = [docPath stringByAppendingPathComponent:uniqueName];
        
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        //如有此文件则直接返回
        if ([[NSFileManager defaultManager] fileExistsAtPath:resultPath]) {
            self.Mp4FilePath = resultPath;
            [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
            return;
        }
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                 {
                     NSLog(@"视频格式转换出错Unknown");
                     [self.view toastShow:@"上传视频出错，重新上传"];
                 }
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                 {
                     NSLog(@"视频格式转换出错Waiting");
                     [self.view toastShow:@"上传视频出错，重新上传"];
                 }
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                 {
                     NSLog(@"视频格式转换出错Exporting");
                     [self.view toastShow:@"上传视频出错，重新上传"];
                 }
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                 {
                     [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
                     self.Mp4FilePath = resultPath;
                     NSLog(@"mp4 file size:%lf MB",[NSData dataWithContentsOfURL:exportSession.outputURL].length/1024.f/1024.f);
                     NSData *da = [NSData dataWithContentsOfFile:resultPath];
                     NSLog(@"da:%lu",(unsigned long)da.length);
                 }
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                 {
                     NSLog(@"视频格式转换出错Unknown");
                     [self.view toastShow:@"上传视频出错，重新上传"];
                 }
                     break;
                     
                 case AVAssetExportSessionStatusCancelled:
                 {
                     NSLog(@"视频格式转换出错Cancelled");
                     [self.view toastShow:@"上传视频出错，重新上传"];
                 }
                     break;
             }
             
         }];
        
    }
}

-(void)updateVideo{
    if (!self.mainView.titleTF.text.length) {
        [self.view toastShow:@"请输入标题"];
        return ;
    }
    if (self.videoDic && [self needUploadVideo]) {
        [self uploadMovie:self.videoDic Mp4FilePath:self.Mp4FilePath];
        return;
    }
    if (self.img && [self needUploadImg]) {
        [self updateImg:self.img];
        return;
    }
    [self commitVideoInfo];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)videoLabEdit:(UITextField*)tf{
//    if ([tf.text containsString:@"http"]) {
//        <#statements#>
//    }
}

-(void)click_commit{
    
    if (self.videoID != nil && self.videoID.length > 0) {
        [self updateVideo];
        return;
    }
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil || token.length == 0) {
        
        SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
        SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    if (self.isSelectedCell == NO) {
        self.isSelectedCell = YES;
        [SVCCommunityApi checkVIPWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if(code == -997){
                SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
                SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
            }else{
                if (!self.mainView.titleTF.text.length) {
                    [self.view toastShow:@"请输入标题"];
                    return ;
                }
                
                if (!self.videoDataInfo && [self needUploadVideo]) {
                    [self uploadMovie:self.videoDic Mp4FilePath:self.Mp4FilePath];
                    return;
                }
                if (!self.imgDataInfo && [self needUploadImg]) {
                    [self updateImg:self.img];
                    return;
                }
                [self commitVideoInfo];
            }
        } andfail:^(NSError *error) {
            self.isSelectedCell = NO;
        }];
    }
}

-(BOOL)needUploadVideo{
    if (self.mainView.videoLab.text.length>0) {
        if ([self.mainView.videoLab.text isEqualToString: self.videoPath]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

-(BOOL)needUploadImg{
    if (self.mainView.imgLab.text.length>0) {
        if ([self.mainView.imgLab.text isEqualToString: self.imgPath]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

//配置返回按钮的颜色和大小
- (void)configBarButtonItemAppearance {
    UIBarButtonItem *barItem;
    if (iOS9) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TOPCONTROLLER class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[TOPCONTROLLER class], nil];
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = FontSize(14);
    [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

@end
