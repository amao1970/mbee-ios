//
//  VDAtentionListVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDAtentionListVC.h"
#import "VDAtentionModel.h"
#import "VDAtentionListCell.h"
#import "VDUserCenterVC.h"

@interface VDAtentionListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<VDAtentionModel*> *dataList;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation VDAtentionListVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的关注";
    [self setUpTableView];
    [WsHUD showHUDWithLabel:@"正在加载..." modal:NO timeoutDuration:40.0];
    [self getNetData];
}

-(void)getNetData{
    
    [JXAFNetWorking method:@"/mobile/user/myActor" parameters:nil finished:^(JXRequestModel *obj) {
        self.dataList = [VDAtentionModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"list"] error:nil];
        [self.tableView reloadData];
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    } failed:^(JXRequestModel *obj) {
        [self.tableView.mj_header endRefreshing];
        [WsHUD hideHUD];
    }];
}

-(void)setUpTableView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VDAtentionListCell" bundle:nil] forCellReuseIdentifier:@"VDAtentionListCell"];
    
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
                VDUserCenterVC *targent = [[VDUserCenterVC alloc] init];
                targent.userID = self.dataList[indexPath.row].vid ;
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
    VDAtentionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDAtentionListCell"];
    [cell.img jx_setImageWithUrl:self.dataList[indexPath.row].avatar];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].nickname];
    cell.descLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].desc];
    cell.fansLab.text = [NSString stringWithFormat:@"粉丝数:%@",self.dataList[indexPath.row].visit];
    cell.isSelect = YES;
    cell.cancelbut.tag = indexPath.row;
    [cell.cancelbut addTarget:self action:@selector(click_guanzhu:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)click_guanzhu:(UIButton*)btn{
    [WsHUD showHUDWithLabel:@"正在提交..." modal:NO timeoutDuration:40.0];
    [JXAFNetWorking method:@"/mobile/video/ulike" parameters:@{@"id":self.dataList[btn.tag].vid} finished:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        if ([[obj getResultDictionary][@"status"] integerValue] == 0) {
            [self.view toastShow:@"已取消关注"];
        }else{
            [self.view toastShow:@"已关注"];
        }
        
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];
}
@end
