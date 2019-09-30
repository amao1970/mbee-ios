//
//  VDUploadVideoListVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDUploadVideoListVC.h"
#import "VDUploadVideoCell.h"
#import "VDUploadVideoListModel.h"

#import "SVCVideoDetailViewController.h"
#import "VDUploadVideoVC.h"

#import "JXErrorView.h"

@interface VDUploadVideoListVC ()<UITableViewDelegate,UITableViewDataSource,JXErrorViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXErrorView *errorView;
@property (nonatomic, strong) NSMutableArray<VDUploadVideoListModel*> *dataList;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation VDUploadVideoListVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}
//你还没有发布作品哟，快去上传视频赚取收入吧
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpTableView];
    self.title = @"我的作品";
    [self getNetData];
    [self.tableView addSubview:self.errorView];
    UIBarButtonItem *itemBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"上传"] style:UIBarButtonItemStyleDone target:self action:@selector(goToUploadVideo)];
    self.navigationItem.rightBarButtonItem = itemBtn;
}

-(void)getNetData{
    [JXAFNetWorking method:@"/mobile/user/myVideo" parameters:nil finished:^(JXRequestModel *obj) {
        self.dataList = [VDUploadVideoListModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"list"] error:nil];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (self.dataList.count) {
            self.errorView.hidden = YES;
        }else{
            self.errorView.hidden = NO;
            self.errorView.titleLab.text = @"你还没有发布作品哟，\n快去上传视频赚取收入吧";
        }
    } failed:^(JXRequestModel *obj) {
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)setUpTableView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VDUploadVideoCell" bundle:nil] forCellReuseIdentifier:@"VDUploadVideoCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNetData];
    }];
    [self.view addSubview:self.tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
                SVCVideoDetailViewController *targent = [[SVCVideoDetailViewController alloc] init];
                targent.videoID = self.dataList[indexPath.row].id ;
                targent.isPreview = YES;
                [self.navigationController pushViewController:targent animated:YES];
            }
        } andfail:^(NSError *error) {
            self.isSelectedCell = NO;
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VDUploadVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDUploadVideoCell"];
    cell.stateLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].status];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].title];
    cell.descLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].brief];
    [cell.img jx_setImageWithUrl:self.dataList[indexPath.row].image];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(120);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self.dataList[indexPath.row].isedit isEqualToString:@"0"]) {
            [self.view toastShow:@"不可编辑"];
        }else{
            VDUploadVideoVC *targent = [[VDUploadVideoVC alloc] init];
            targent.videoID = self.dataList[indexPath.row].id;
            [self.navigationController pushViewController:targent animated:YES];
        }
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"编辑";
}

-(void)goToUploadVideo{
    [self.tabBarController setSelectedIndex:2];
    [(JXTabBarController*)self.tabBarController removeOriginControls];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [(JXTabBarController*)self.tabBarController removeOriginControls];
}

-(JXErrorView *)errorView
{
    if (!_errorView) {
        CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCREEN_HEIGHT - Nav_HEIGHT);
        _errorView = [[JXErrorView alloc] initWithMDErrorShowView:rect
                                                contentShowString:@"你还没有发布作品哟，\n快去上传视频赚取收入吧"
                                              MDErrorShowViewType:NoData
                                                      theDelegate:self];
        _errorView.titleLab.text = @"暂无数据";
        _errorView.hidden = YES;
        //        _errorView.tag = allErrorViewTag;
    }
    return _errorView;
}


@end
