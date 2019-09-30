//
//  SVCCludeLiveViewController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCCludeLiveViewController.h"
#import "SVCWonderfulVideoViewController.h"
#import "SVCbannerView.h"
#import <SDCycleScrollView.h>
#import "TXScrollLabelView.h"
#import "SVCIndeModel.h"
#import "SVCRechargeVC.h"
#import "SVCOriginateNovelViewController.h"
@interface SVCCludeLiveViewController ()<SVCBannerProtocol , SDCycleScrollViewDelegate>
@property (nonatomic , weak)SVCbannerView *moviesBannerView;
@property (nonatomic , weak)SVCbannerView *storyBannerView;
@property (nonatomic , weak)SDCycleScrollView *mainScrollerView;
@property (nonatomic , weak)TXScrollLabelView *scrollLabelView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic,weak) UIView *paomaView;
@property (nonatomic , strong)NSMutableArray *linkArr;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */
@end

@implementation SVCCludeLiveViewController

-(NSMutableArray *)linkArr{
    if (!_linkArr) {
        _linkArr = [[NSMutableArray alloc]init];
    }
    return _linkArr;
}

- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (UIView *)paomaView
{
    if (!_paomaView) {
        UIView *viewAnima = [[UIView alloc] init];
        viewAnima.backgroundColor = [UIColor  blackColor];
        viewAnima.alpha = 0.45;
        WS(weakSelf);
        [self.view addSubview:viewAnima];
        [viewAnima mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(0);
            make.right.equalTo(weakSelf.view.mas_right).offset(0);
            make.top.equalTo(weakSelf.view.mas_top).offset(0);
            make.height.equalTo(@(30));
        }];
        _paomaView = viewAnima;
    }
    return _paomaView;
}
- (SDCycleScrollView *)mainScrollerView
{
    if (!_mainScrollerView) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] init];
        WS(weakSelf);
        view.delegate = weakSelf;
        [weakSelf.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(0);
            make.right.equalTo(weakSelf.view.mas_right).offset(0);
            make.top.equalTo(weakSelf.view.mas_top).offset(0);
            make.height.equalTo(@(kScreenWidth/2));
        }];
        _mainScrollerView = view;
    }
    return _mainScrollerView;
}
- (SVCbannerView *)moviesBannerView
{
    if (!_moviesBannerView) {
        SVCbannerView *view = [[SVCbannerView alloc] init];
        WS(weakSelf);
        view.tag = 1206;
        [weakSelf.view addSubview:view];
        view.Vdelegate = weakSelf;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(0);
            make.right.equalTo(weakSelf.view.mas_right).offset(0);
            make.top.equalTo(weakSelf.mainScrollerView.mas_bottom).offset(0);
            make.height.equalTo(@(kScreenWidth/3));
        }];
        _moviesBannerView = view;
    }
    return _moviesBannerView;
}
-(TXScrollLabelView *)scrollLabelView{
    if (!_scrollLabelView) {
        TXScrollLabelView *TXView = [TXScrollLabelView scrollWithTitle:@"" type:TXScrollLabelViewTypeLeftRight velocity:1.5 options:UIViewAnimationOptionCurveEaseInOut];;
        TXView.tx_centerX  = (kScreenWidth - 30) * 0.5;
        TXView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        TXView.scrollSpace = 10;
        TXView.font = [UIFont systemFontOfSize:14];
        TXView.textAlignment = NSTextAlignmentCenter;
        TXView.scrollTitleColor = [UIColor whiteColor];
        TXView.layer.cornerRadius = 5;
        TXView.frame = CGRectMake(30, 0, kScreenWidth - 30, 30);
         [self.paomaView addSubview:TXView];
        _scrollLabelView = TXView;
    }
    return _scrollLabelView;
}

- (SVCbannerView *)storyBannerView
{
    if (!_storyBannerView) {
        SVCbannerView *view = [[SVCbannerView alloc] init];
        WS(weakSelf);
          view.Vdelegate = weakSelf;
        view.tag = 1207;
        [weakSelf.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(0);
            make.right.equalTo(weakSelf.view.mas_right).offset(0);
            make.top.equalTo(weakSelf.moviesBannerView.mas_bottom).offset(0);
            make.height.equalTo(@(kScreenWidth/3));
        }];
        _storyBannerView = view;
    }
    return _storyBannerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getbannerListdata];
    self.mainScrollerView.placeholderImage = [UIImage imageNamed:@"banner"];
    [self addTopview];
    [self.moviesBannerView setbannerImage:@"精彩视频"];
    [self.storyBannerView setbannerImage:@"原创小说"];
    // Do any additional setup after loading the view.
}
- (void)addTopview
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
    imageView.image = [UIImage imageNamed:@"icon_gonggao"];
    [self.paomaView addSubview:imageView];
}
- (void)getbannerListdata
{
    WS(weakSelf);
//       [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20.0];
    [SVCCommunityApi GetBannerListWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WsHUD hideHUD];
        if (code == 0) {
            NSArray *arr = JSON[@"advList"];
//            weakSelf.lableNotice.text = JSON[@"notice"];
            NSString *noticeStr = JSON[@"notice"];
            if (noticeStr.length !=0 && noticeStr !=nil) {
                weakSelf.scrollLabelView.scrollTitle = noticeStr;
                [weakSelf.scrollLabelView beginScrolling];
            }
            for (NSDictionary *dic in arr) {
                [weakSelf.sources addObject:dic[@"image"]];
                SVCIndeModel *model = [SVCIndeModel mj_objectWithKeyValues:dic];
                [weakSelf.linkArr addObject:model];
            }
            weakSelf.mainScrollerView.imageURLStringsGroup = weakSelf.sources;
        }else{
            [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}
#pragma mark --> 图片点击的回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    SVCIndeModel *model = self.linkArr[index];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:model.link]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.link]];
    }
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}


- (void)bannerDidclick:(NSInteger)tag
{
    if (self.isSelectedCell == NO) {
    self.isSelectedCell = YES;
    SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
    NSString *token =  [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    if (user.uid.length < 1 ||  token.length < 1) {
        [self gotoLoginVC];
    }else{ // 检测vip
        [SVCCommunityApi checkVIPWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                if (tag == 1206) {
                    [self gotoWonderfulVC];
                }else{
                    // 原创小说
                    [self gotoOriginateNovelVC];
                }
            }else if (code == -1){
                // 不是vip 进入充值界面
                [self gotochargeVC:msg];
            }else if(code == -997){
                [self gotoLoginVC];
            }
        } andfail:^(NSError *error) {
            
        }];
    }
    }
}


- (void)gotoWonderfulVC{
    // 精彩视频
    SVCWonderfulVideoViewController *vc = [[SVCWonderfulVideoViewController alloc] init];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoOriginateNovelVC{
    SVCOriginateNovelViewController *vc = [[SVCOriginateNovelViewController alloc] init];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)gotoLoginVC{
    SVCLoginViewController *logVC = [[SVCLoginViewController alloc] init];
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:nav animated:YES completion:nil];
}



- (void)gotochargeVC:(NSString *)msg
{
    WS(weakSelf);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* shareAction = [UIAlertAction actionWithTitle:@"分享赚时间" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * action) {
        SVCinvateFriendsViewController *chargeVC = [[SVCinvateFriendsViewController alloc] init];
        [weakSelf.navigationController pushViewController:chargeVC animated:YES];
    }];
    UIAlertAction* okeyAction = [UIAlertAction actionWithTitle:@"充值续费" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * action) {
        SVCRechargeVC *chargeVC = [[SVCRechargeVC alloc] init];
        [weakSelf.navigationController pushViewController:chargeVC animated:YES];
    }];
    [alert addAction:okeyAction];
    [alert addAction:shareAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
