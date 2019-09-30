//
//  SVCTextReadViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTextReadViewController.h"
#import "SVCNovelDetailModel.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "HMShowWebImgView.h"
#import <YBImageBrowser/YBImageBrowser.h>

@interface SVCTextReadViewController ()<UIWebViewDelegate>
@property(nonatomic, copy) NSString *text; /**<<#属性#> */
@property(nonatomic, copy) NSString *novelID; /**<<#属性#> */
@property(nonatomic, strong) UITextView *textView; /**<<#属性#> */
@property(nonatomic, strong) UIWebView *webview; /**<<#属性#> */
// 查看大图
@property (nonatomic, strong) HMShowWebImgView *showWebImgView;
@end

@implementation SVCTextReadViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [WsHUD hideHUD];
}
-(void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SVCMarginColorf5;
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webview.backgroundColor = SVCMarginColorf5;
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    if (self.isImg) {
        [self getImgInfo];
    }else{
        [self getNoveInfo];
    }
}

-(void)getNoveInfo{
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setSafeObject:_novelID forSafeKey:@"id"];
    [SVCCommunityApi getnoveInfoWithParams:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        if (code == 0) {
            SVCNovelDetailModel *model = [SVCNovelDetailModel mj_objectWithKeyValues:json];
            NSString *subtitle = @"";
            if (self.novelModel.nickname.length) {
                subtitle = [NSString stringWithFormat:@"%@  %@",self.novelModel.nickname, self.novelModel.createtime];;
            }else{
                subtitle = [NSString stringWithFormat:@"%@", self.novelModel.createtime];;
            }
            self.navigationItem.title = @"内容";//model.title;
            NSString *html = [NSString stringWithFormat:@"<html>\
                              <b style=\"color:#000000;font-size=52px\">%@</b>\
                              <p></p>\
                              <div style=\"color:#464646;font-size=26px\">%@</div>\
                              </html>",model.title,model.content];
            NSLog(@"html = %@",html);
            [self.webview loadHTMLString:html baseURL:nil];
            self.imgURLS = (NSArray*)json[@"imglist"];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
    }];
}

-(void)getImgInfo{
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setSafeObject:_novelID forSafeKey:@"id"];
    [SVCCommunityApi getImgInfoWithParams:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        if (code == 0) {
            SVCNovelDetailModel *model = [SVCNovelDetailModel mj_objectWithKeyValues:json];
            self.navigationItem.title = model.title;
            NSString *html = [NSString stringWithFormat:@"<html><div style=\"color:#464646;font-size=26px\">%@</div></html>",model.content];
            NSLog(@"html = %@",html);
            [self.webview loadHTMLString:html baseURL:nil];
            
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
    }];
}

- (instancetype)initWithNovelID:(NSString *)novelID{
    if (self = [super init]) {
        _novelID = novelID;
    }
    return self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"已经开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    NSLog(@"加载完成");
    [WsHUD hideHUD];
    
    JSContext *context = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //核心方法如下
    //此处的getMessage和JS方法中的getMessage名称一致.
    context[@"browerOfImg"] = ^() {
        NSArray *arguments = [JSContext currentArguments];
        JSValue *value = arguments.firstObject ;
        
        NSMutableArray <YBImageBrowseCellData*> *tmpAry = [NSMutableArray array];
        [self.imgURLS enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 网络图片
            YBImageBrowseCellData *data0 = [YBImageBrowseCellData new];
            data0.url = obj;
            [tmpAry addObject:data0];
        }];
        
        // 设置数据源数组并展示
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSourceArray = tmpAry;
        browser.currentIndex = [value toString] .integerValue;
        [browser show];
//        [self.showWebImgView showBigImage:self.imgURLS
//                                  atIndex: [value toString] .integerValue
//                                    title:@""];
//        for (JSValue *jsValue in arguments) {
//            NSLog(@"=======%@",jsValue);
//        }
    };
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view toastShow:@"加载失败"];
    [WsHUD hideHUD];
}

-(HMShowWebImgView *)showWebImgView
{
    if (!_showWebImgView) {
        _showWebImgView = [[HMShowWebImgView alloc] init];
    }
    return _showWebImgView;
}


@end
