//
//  UIVIPMoviesViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "UIVIPMoviesViewController.h"
#import "WsHUD.h"
#import "AppDelegate.h"
#import "SVCPlayerWebViewController.h"

@interface UIVIPMoviesViewController ()<UIWebViewDelegate>

@property(nonatomic, weak) UIWebView *webView; /**<<#属性#> */
@property (strong, nonatomic) UIButton *playBtn;
@property (copy, nonatomic) NSString *parsingStr;
@property (copy, nonatomic) NSString *urlHost;
@property (copy, nonatomic) NSString *compareStr;
@property (copy, nonatomic) NSString *videoStr;
@end

@implementation UIVIPMoviesViewController

- (instancetype)initWithUrl:(NSString *)VIPMoviesUrl type:(WebViewType)type{
    if (self = [super init]) {
        _VIPMoviesUrl = VIPMoviesUrl;
        _type = type;
        _parsingStr = @"http://vip.baiyug.cn/index.php?url=";
        _compareStr = @"http://m.1905.com/m/api/wechathttps";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    [self setupPlayBtn];
}
- (void)setupPlayBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:BtnbgColor];
    btn.frame = CGRectMake(20, GetHeightByScreenHeigh(280), 120, 44);
    btn.layer.cornerRadius = 22;
    btn.layer.masksToBounds = YES;
    btn.hidden = YES;
    btn.alpha = 0.78;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"VIP特权播放" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:btn aboveSubview:self.webView];
    _playBtn = btn;
}

- (void)returnBack
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        // 清空
        self.videoStr = nil;
    }else{
        [WsHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)setupWebView{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    webview.delegate = self;
    self.webView = webview;
    [self.view addSubview:webview];
    
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    if (_type == VIPMovies) {
        self.navigationItem.title = @"VIP影院";
        [SVCCommunityApi getVIPMoviceUrlWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSString *url) {
            if (code == 0) {
                if ([url hasPrefix:@"http://"]) {
                    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                    self.urlHost = request.URL.host;
                    self.VIPMoviesUrl = url;
                    [_webView loadRequest:request];
                }else{
                    [WsHUD hideHUD];
                    [self.view toastShow:@"后台未配置地址或配置地址出错"];
                    NSLog(@"url的地址不正确");
                }
            }else{
                
            }
        } andfail:^(NSError *error) {
            
        }];
    }else if (_type == TVLive){
        self.navigationItem.title = @"卫视直播";
        [SVCCommunityApi getTVUrlWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSString *url) {
            if (code == 0) {
                if ([url hasPrefix:@"http://"]) {
                    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                    [_webView loadRequest:request];
                }else{
                    [WsHUD hideHUD];
                    [self.view toastShow:@"后台未配置地址或配置地址出错"];
                    NSLog(@"url的地址不正确");
                }
            }else{
                
            }
        } andfail:^(NSError *error) {
            
        }];
    }
    
}


- (void)play{
    if (self.videoStr.length) {
        SVCPlayerWebViewController *vc = [[SVCPlayerWebViewController alloc] initWithPlayUrl:[NSString stringWithFormat:@"%@%@", self.parsingStr,self.videoStr]];
        vc.title = @"VIP影院";
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        [self.view toastShow:@"请选择播放的视频"];
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"URL == %@",[NSString stringWithFormat:@"%@",request.URL]);
    if ([request.URL.absoluteString hasPrefix:self.compareStr]) {
        if ([request.URL.absoluteString isEqualToString:self.VIPMoviesUrl]) {
            _videoStr = nil;
        }else{
            _videoStr = request.URL.absoluteString;
        }
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"已经开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成");
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
    
    if ([self.webView.request.URL.absoluteString isEqualToString:self.VIPMoviesUrl]) {
        self.playBtn.hidden = NO;
    }
    if ([self.webView.request.URL.absoluteString hasPrefix:self.compareStr]) {
        self.playBtn.hidden = NO;
    }
    [WsHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //    [self.view toastShow:@"加载失败"];
    [WsHUD hideHUD];
}


@end
