//
//  SVCPlayerWebViewController.m
//  SmartValleyCloudSeeding
//
//  Created by Mac on 2018/8/2.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCPlayerWebViewController.h"

@interface SVCPlayerWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webview;

@end

@implementation SVCPlayerWebViewController

- (instancetype)initWithPlayUrl:(NSString *)playUrl{
    if (self = [super init]) {
        _playUrl = playUrl;
        // Do any additional setup after loading the view.
        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        webview.delegate = self;
        self.webview = webview;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.playUrl]];
        [self.view addSubview:webview];
        [webview loadRequest:request];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)returnBack
{
    if (self.webview.canGoBack) {
        [self.webview goBack];
    }else{
        [WsHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
