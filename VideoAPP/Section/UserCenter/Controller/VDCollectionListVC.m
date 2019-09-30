//
//  VDCollectionListVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDCollectionListVC.h"
#import "VDCollectionCell.h"
#import "VDCollectionModel.h"

#import "SVCVideoDetailViewController.h"

@interface VDCollectionListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<VDCollectionModel*> *dataList;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation VDCollectionListVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self setUpTableView];
    [self getNetData];
}

-(void)getNetData{
    [JXAFNetWorking method:@"/mobile/user/mySc" parameters:nil finished:^(JXRequestModel *obj) {
        self.dataList = [VDCollectionModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"list"] error:nil];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failed:^(JXRequestModel *obj) {
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)setUpTableView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VDCollectionCell" bundle:nil] forCellReuseIdentifier:@"VDCollectionCell"];
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
            if (code == 0) {
                SVCVideoDetailViewController *targent = [[SVCVideoDetailViewController alloc] init];
                targent.videoID = self.dataList[indexPath.row].id;
                [self.navigationController pushViewController:targent animated:YES];
            }else if (code == -1){
                // 不是vip 进入充值界面
                [self gotochargeVC:msg];
            }else if(code == -997){
                SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
                SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
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
    VDCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDCollectionCell"];
    [cell.img jx_setImageWithUrl:self.dataList[indexPath.row].image];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].title];
    cell.desc.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].brief];
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
        
            [WsHUD showHUDWithLabel:@"正在提交..." modal:NO timeoutDuration:40.0];
            [JXAFNetWorking method:@"/mobile/video/tlike" parameters:@{@"id":self.dataList[indexPath.row].id} finished:^(JXRequestModel *obj) {
                [WsHUD hideHUD];
                [self.dataList removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
                
            } failed:^(JXRequestModel *obj) {
                [WsHUD hideHUD];
            }];
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
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
