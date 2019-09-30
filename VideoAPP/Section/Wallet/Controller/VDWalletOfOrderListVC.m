//
//  VDWalletOfOrderListVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDWalletOfOrderListVC.h"
#import "VDWalletOfOrderListCell.h"
#import "VDWalletOrderListModel.h"

@interface VDWalletOfOrderListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<VDWalletOrderListModel*> *dataList;
@property (nonatomic, strong) NSString *money;

@end

@implementation VDWalletOfOrderListVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"提现记录";
    self.money = @"";
//    self.dataList = @[@"",@"",@""];
    [self setUpTableView];
    [self getNetData];
}

-(void)getNetData{
    [JXAFNetWorking method:@"/mobile/user/tixian" parameters:nil finished:^(JXRequestModel *obj) {
        self.dataList = [VDWalletOrderListModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"list"] error:nil];
        [self.tableView reloadData];
        self.money = [NSString stringWithFormat:@"%@",[obj getResultDictionary][@"money"]];
    } failed:^(JXRequestModel *obj) {
        
    }];
}

-(void)setUpTableView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VDWalletOfOrderListCell" bundle:nil] forCellReuseIdentifier:@"VDWalletOfOrderListCell"];
    [self.view addSubview:self.tableView];
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
    VDWalletOfOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDWalletOfOrderListCell"];
//    cell.textLabel.text = self.dataList[indexPath.row];
//    cell.titleLab.text
    cell.stateLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].status];
    cell.dateLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].createtime];
    cell.moneyLab.text = [NSString stringWithFormat:@"¥%@",self.dataList[indexPath.row].money];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(60);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, JXHeight(30))];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(JXWidth(17), 0, SCR_WIDTH, JXHeight(30));
    titleLab.font = FontSize(14);
    titleLab.textColor = [UIColor hexStringToColor:@"b0b0b0"];
    titleLab.text = [NSString stringWithFormat:@"总收入:%@元",self.money]; // @"总收入:xxx";
    [view addSubview:titleLab];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return JXHeight(30);
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

@end
