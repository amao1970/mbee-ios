//
//  SVCAdvPoliciesViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/5.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCAdvPoliciesViewController.h"
#import "SVCAdvPoliciesModel.h"

@interface SVCAdvPoliciesViewController ()<UIWebViewDelegate>
@property(nonatomic, copy) NSString *text; /**<<#属性#> */
@property(nonatomic, copy) NSString *novelID; /**<<#属性#> */
@property(nonatomic, strong) UITextView *textView; /**<<#属性#> */
@property(nonatomic, strong) UIWebView *webview; /**<<#属性#> */

@end

@implementation SVCAdvPoliciesViewController

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
    self.title = @"代理政策";
    self.view.backgroundColor = SVCMarginColorf5;
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webview.backgroundColor = SVCMarginColorf5;
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    if (self.isAdvPolicies) {
        [self getAdvInfo];
    }else{
        [self getAgentInfo];
    }
}

-(void)getAdvInfo{
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setSafeObject:_novelID forSafeKey:@"id"];
    [SVCCommunityApi getadvInfoWithParams:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *json) {
        if (code == 0) {
            SVCAdvPoliciesModel *model = [SVCAdvPoliciesModel mj_objectWithKeyValues:json];
            self.navigationItem.title = model.title;
            NSString *html = [NSString stringWithFormat:@"<html><div style=\"color:#464646;font-size=26px\">%@</div></html>",model.content];
            NSLog(@"html = %@",html);
            [self.webview loadHTMLString:html baseURL:nil];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
    }];
}

-(void)getAgentInfo{
    WS(weakSelf);
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    [SVCCommunityApi GetcustomerInfoWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            NSString *contact = [JSON[@"desc"] isEqual:[NSNull new]] ? @"": JSON[@"desc"];
            NSString *html = [NSString stringWithFormat:@"<html><div style=\"color:#464646;font-size=26px\">%@</div></html>",contact];
            NSLog(@"html = %@",html);
            [self.webview loadHTMLString:html baseURL:nil];
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
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
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view toastShow:@"加载小说失败"];
    [WsHUD hideHUD];
}


@end
