//
//  SVCMoviePlayerViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/25.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCMoviePlayerViewController.h"

@interface SVCMoviePlayerViewController ()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webview; /**<<#属性#> */
@property (nonatomic, strong) NSString *movieURL;

@end

@implementation SVCMoviePlayerViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_movieURL]]];
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
}

- (instancetype)initWithMovieURL:(NSString *)movieURL{
    if (self = [super init]) {
        _movieURL = movieURL;
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
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view toastShow:@"加载失败"];
    [WsHUD hideHUD];
}




@end
