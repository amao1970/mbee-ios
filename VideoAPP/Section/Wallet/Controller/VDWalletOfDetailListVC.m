//
//  VDWalletOfDetailListVC.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDWalletOfDetailListVC.h"
#import "VDWalletOfDetailCell.h"
#import "VDWalletDetailListModel.h"

@interface VDWalletOfDetailListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<VDWalletDetailListModel*> *dataList;
@property (nonatomic, strong) NSString *money;

@end

@implementation VDWalletOfDetailListVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"收入明细";
    self.money = @"";
//    self.dataList = @[@"",@"",@""];
    [self setUpTableView];
    [self getNetData];
}

-(void)getNetData{
    [JXAFNetWorking method:@"/mobile/user/moneylog" parameters:nil finished:^(JXRequestModel *obj) {
        self.dataList = [VDWalletDetailListModel arrayOfModelsFromDictionaries:[obj getResultDictionary][@"list"] error:nil];
        self.money = [NSString stringWithFormat:@"%@",[obj getResultDictionary][@"money"]];
        [self.tableView reloadData];
    } failed:^(JXRequestModel *obj) {
        
    }];
}

-(void)setUpTableView{
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VDWalletOfDetailCell" bundle:nil] forCellReuseIdentifier:@"VDWalletOfDetailCell"];
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
    VDWalletOfDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VDWalletOfDetailCell"];
//    cell.textLabel.text = self.dataList[indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].title];
    cell.dateLab.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].createtime];
    cell.moneyLab.text = [NSString stringWithFormat:@"+%@",self.dataList[indexPath.row].money];
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
    titleLab.text = [NSString stringWithFormat:@"总收入:%@",self.money];
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
