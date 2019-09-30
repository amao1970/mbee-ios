//
//  SVCWonderfulVideoViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCWonderfulVideoViewController.h"
#import "SVCWonderfulTableViewCell.h"
#import "SVCWonderfulVideoModel.h"
#import "SVCPlayerViewController.h"


@interface SVCWonderfulVideoViewController ()


@end

@implementation SVCWonderfulVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    [self setupNav];
    [self requestWonderfulVideo];
    
}

- (void)setupNav{
    self.navigationItem.title = @"精彩视频";
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setTitle:@"换一批" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:SVCColorFromRGB(0x808080) forState:(UIControlState)UIControlStateNormal];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    self.navigationItem.rightBarButtonItem = refreshItem;
}

- (void)requestWonderfulVideo{
    [SVCCommunityApi getWonderfulVideoWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSArray *json) {
        // 请求成功
        if (code == 0) {
            if ([json isKindOfClass:[NSArray class]]) {
                self.dataArray = [SVCWonderfulVideoModel mj_objectArrayWithKeyValuesArray:json];
                [self.tableView reloadData];
            }
        }
    } andfail:^(NSError *error) {
        // 暂无视频
    }];
}

-(void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshBtnClick{
    [self requestWonderfulVideo];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =SVCColorFromRGB(0xeeeeee);
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return GetHeightByScreenHeigh(5);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return GetHeightByScreenHeigh(80);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SVCWonderfulTableViewCell *cell = [SVCWonderfulTableViewCell cellWithTableView:tableView];
    SVCWonderfulVideoModel *videoModel = [self.dataArray objectAtSafeIndex:indexPath.section];
    cell.videoModel = videoModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SVCWonderfulVideoModel *videoModel = [self.dataArray objectAtSafeIndex:indexPath.section];
    SVCPlayerViewController *vc = [[SVCPlayerViewController alloc] initWithVideoUrl:videoModel.link];
   
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

//支持旋转
- (BOOL)shouldAutorotate{
    return YES;
}
//
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
