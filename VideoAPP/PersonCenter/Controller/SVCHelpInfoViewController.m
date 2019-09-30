//
//  SVCHelpInfoViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCHelpInfoViewController.h"
#import "SVCHelpInfoModel.h"

@interface SVCHelpInfoViewController ()<UIWebViewDelegate>

//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) NSString *MsgId;
@property (nonatomic, strong) SVCHelpInfoModel *data ;
@property(nonatomic, strong) UIWebView *webview; /**<<#属性#> */

@end

@implementation SVCHelpInfoViewController

-(instancetype)initWithMsgId:(NSString *)MsgId
{
    self = [super init];
    if (self) {
        self.MsgId = MsgId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";

    [WsHUD showHUDWithLabel:@"正在加载中..." modal:YES timeoutDuration:20.0];
    [self getNetData];
}

-(void)setUpView{
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,  SCR_WIDTH, SCREEN_HEIGHT-Nav_HEIGHT)];
    self.webview.backgroundColor = SVCMarginColorf5;
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    
    
    NSString *html = [NSString stringWithFormat:@"<html>\
                      <div style=\"color:#464646;font-size=26px\">%@</div>\
                      </html>",self.data.content];
    NSLog(@"html = %@",html);
    [self.webview loadHTMLString:html baseURL:nil];
    
//    self.scrollView.contentSize = CGSizeMake(SCR_WIDTH, contentLab.bottom  + 10);
}

#pragma mark -- getNetData
-(void)getNetData{
    if (!self.MsgId) {
        self.MsgId = @"";
    }
    WS(weakSelf);
    [SVCCommunityApi UserHelpInfoWithNSDiction:@{@"id":self.MsgId} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            NSDictionary *lists = JSON[@"lists"];
           self.data = [[SVCHelpInfoModel alloc]initWithDictionary:lists error:nil]  ;
            [self setUpView];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
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
    
//    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
//    self.webview.height = [htmlHeight floatValue];
//    self.scrollView.contentSize = CGSizeMake(SCR_WIDTH, self.webview.bottom  + 10);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view toastShow:@"加载失败"];
    [WsHUD hideHUD];
}

#pragma mark -- 懒加载

//-(UIScrollView *)scrollView
//{
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.bounces = NO;
//        _scrollView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT - 10);
//        _scrollView.backgroundColor = [UIColor whiteColor];
//        _scrollView.contentSize = CGSizeMake(SCR_WIDTH, SCR_HIGHT-Nav_HEIGHT);
//    }
//    return _scrollView;
//}

-(UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    }
    return _detailLab;
}

- (void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
