//
//  VDUserCenterVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/7.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDUserCenterVC.h"

#import "VDUserCenterCell.h"
#import "VDAtentionListCell.h"

#import "VDUserCenterModel.h"

#import "SVCVideoDetailViewController.h"

@interface VDUserCenterVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<VDUserCenterModel*> *dataList;
@property (nonatomic, strong) NSDictionary *userInfoDic;
@property(nonatomic, assign) BOOL isSelectedCell; /**<属性 */

@end

@implementation VDUserCenterVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人主页";
    [self setUpTableView];
    [WsHUD showHUDWithLabel:@"正在加载..." modal:NO timeoutDuration:40.0];
    [self getNetData];
}

-(void)getNetData{
    
    [JXAFNetWorking method:@"/mobile/user/homePage" parameters:@{@"id":self.userID} finished:^(JXRequestModel *obj) {
        self.userInfoDic = [obj getResultDictionary][@"list"];
        self.dataList = [VDUserCenterModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"list"][@"videolist"] error:nil];
        [self.tableView reloadData];
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)setUpTableView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VDUserCenterCell" bundle:nil] forCellReuseIdentifier:@"VDUserCenterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VDAtentionListCell" bundle:nil] forCellReuseIdentifier:@"VDAtentionListCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNetData];
    }];
    [self.view addSubview:self.tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
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
                    [self.navigationController pushViewController:targent animated:YES];
                }
            } andfail:^(NSError *error) {
                self.isSelectedCell = NO;
            }];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.userInfoDic ? 1 : 0;
    }
    return self.dataList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        VDAtentionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDAtentionListCell"];
        [cell.img jx_setImageWithUrl:[NSString stringWithFormat:@"%@",self.userInfoDic[@"avatar"]]];
        cell.titleLab.text = [NSString stringWithFormat:@"%@",self.userInfoDic[@"nickname"]];
        cell.descLab.text = [NSString stringWithFormat:@"%@",self.userInfoDic[@"desc"]];
        cell.fansLab.text = [NSString stringWithFormat:@"粉丝数:%@",self.userInfoDic[@"visit"]];
        cell.isSelect = [self.userInfoDic[@"guanzhu"] isEqualToString:@"已关注"];
        [cell.cancelbut addTarget:self action:@selector(click_guanzhu:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        VDUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDUserCenterCell"];
//        cell.textLabel.text = self.dataList[indexPath.row];
        [cell.img jx_setImageWithUrl:self.dataList[indexPath.row].image];
        cell.titleLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].title];
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        
        paragraphStyle.lineSpacing = 5;
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
        
        cell.titleLab.attributedText = [[NSAttributedString alloc] initWithString:cell.titleLab.text attributes:attributes];
        cell.descLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].brief];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return JXHeight(100);
    }else{
        return JXHeight(120);
    }
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
    [JXAFNetWorking method:@"/mobile/video/ulike" parameters:@{@"id":self.userID} finished:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
        if ([[obj getResultDictionary][@"status"] integerValue] == 0) {
            [self.view toastShow:@"已取消关注"];
        }else{
            [self.view toastShow:@"已关注"];
        }
        [self getNetData];
    } failed:^(JXRequestModel *obj) {
        [WsHUD hideHUD];
    }];
}

@end
