//
//  SVCRecommendVC.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCRecommendVC.h"

#import "SVCRechargeVC.h"
#import "XMLiveViewController.h"

// view
#import "JXRecommendCell.h"
#import "SVCHomePageTopView.h"
#import "SVCRecommendHeadView.h"

// model
#import "JXRecommendModel.h"
#import "SVCLiveModel.h"
#import "SVCIndeModel.h"

@interface SVCRecommendVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<JXRecommendModel*> *dataAry;
@property (nonatomic, strong) SVCHomePageTopView *topView;
@property (nonatomic, strong) SVCRecommendHeadView *sectionHeadView;

/** 提示系统信息 */
@property (nonatomic,copy) NSDictionary *systemMessage;
@property (nonatomic,strong) NSMutableArray<SVCIndeModel*> *banDataAry;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

@end

@implementation SVCRecommendVC
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMainView];
    [self getNetData];
    [self getOnbordData];
    [self getBannerListData];
}

-(void)getOnbordData{
    [SVCCommunityApi getOnbordCategoryWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *jsonArr) {
        if (code == 0) {
            if ([jsonArr isKindOfClass:[NSDictionary class]]) {
                if (jsonArr) {
                    self.systemMessage = jsonArr;// [SVCOnbordModel mj_objectArrayWithKeyValuesArray:jsonArr];
                }else{
                    NSLog(@"没有分类数据");
                }
            }
        }
    } andfail:^(NSError *error) {
        
    }];
}

-(void)getNetData{
    WS(weakSelf);
    [SVCCommunityApi getRecommendWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSArray *arr = JSON[@"lists"];
            self.dataAry = [JXRecommendModel mj_objectArrayWithKeyValuesArray:arr];
            NSString *titleStr = [NSString stringWithFormat:@"在线主播 %@",JSON[@"count"]];
            // 初始化属性字符串
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor hexStringToColor:@"555555"] range:NSMakeRange(0, 4)];
            self.sectionHeadView.playerNum.attributedText = attrStr;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view toastShow:msg];
        }
        [WsHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)extracted:(SVCRecommendVC *const __weak)weakSelf {
    [SVCCommunityApi GetBannerListWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        self.banDataAry = [NSMutableArray array];
        if (code == 0) {
            NSArray *arr = JSON[@"advList"];
            NSMutableArray *ImageArray = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                SVCIndeModel *model = [SVCIndeModel mj_objectWithKeyValues:dic];
                [weakSelf.banDataAry addObject:model];
                [ImageArray addObject:model.image];
            }
            self.topView.imageArr = ImageArray;
            self.topView.notice = JSON[@"notice"];
        }else{
            [weakSelf.view toastShow:msg];
        }
        
        [WsHUD hideHUD];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}

-(void)getBannerListData{
    WS(weakSelf);
    [self extracted:weakSelf];
}

-(void)setUpMainView{
    self.topView = [[SVCHomePageTopView alloc] init];
    self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kScreenWidth/2.0);
    WS(weakSelf)
    self.topView.adListClick = ^(NSInteger index) {
        NSString *str = weakSelf.banDataAry[index].link;
        if (!str.length) {
            return;
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    CGRect rect = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - Nav_HEIGHT - Tabbar_HEIGHT - GetHeightByScreenHeigh(45)+44);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"JXRecommendCell" bundle:nil] forCellReuseIdentifier:@"JXRecommendCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_header beginRefreshing];
        [weakSelf getNetData];
        [weakSelf getBannerListData];
        [weakSelf getOnbordData];
    }];
    [self.view addSubview:self.tableView];
    
    self.sectionHeadView = [SVCRecommendHeadView getViewFormNSBunld];
    self.sectionHeadView.frame = CGRectMake(0, self.topView.height + JXHeight(8), SCR_WIDTH, JXHeight(35));
    
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, SCR_WIDTH, self.sectionHeadView.bottom);
    [headView addSubview:self.topView];
    [headView addSubview:self.sectionHeadView];
    self.tableView.tableHeaderView = headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JXRecommendCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"JXRecommendCell"];
//    NSString*cellID = [NSString stringWithFormat:@"%@%zd", @"JXRecommendCell", indexPath.row];
//    JXRecommendCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
//    //解决xib复用数据混乱问题
//    if (nil == cell) {
//        cell= (JXRecommendCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"JXRecommendCell" owner:self options:nil]  lastObject];
//        [cell setValue:cellID forKey:@"reuseIdentifier"];
//    }
//    JXRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JXRecommendCell"];
    [cell reloadWithModel:self.dataAry[indexPath.section]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(280);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return JXHeight(8);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSelectedCell == NO) {
        self.isSelectedCell = YES;
        WS(weakSelf);
        BKNetworkHelper *hepl = [BKNetworkHelper shareInstance];
        NSString *xmurl = [NSString stringWithFormat:@"%@mobile/index/checkUser",BASE_API];
        [hepl POST:xmurl Parameters:nil Success:^(id responseObject) {
            
            NSString *strMsg = [responseObject objectForKey:@"msg"];
            if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                NSDictionary *dic = [responseObject objectForKey:@"data"];
                NSString *appmsg = [dic objectForKey:@"app_sys_msg"];
                [weakSelf pusuToVc:indexPath.section and:appmsg];
            }else if ([[responseObject objectForKey:@"code"] integerValue] == -1){
                [self gotochargeVC:responseObject[@"msg"]
                 ];
            }else if([[responseObject objectForKey:@"code"] integerValue] == - 997){
                SVCLoginViewController *loginVC = [[SVCLoginViewController alloc] init];
                SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
            }else{
                [weakSelf.view toastShow:strMsg];
                return;
            }
        } Failure:^(NSError *error) {
            self.isSelectedCell = NO;
            [weakSelf.view toastShow:netFailString];
        }];
    }
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

- (void)pusuToVc:(NSInteger)index and:(NSString *)appMsg
{
    SVCLiveModel *liveModel = [SVCLiveModel new];
    JXRecommendModel *model = self.dataAry[index];
    liveModel.title = model.title;
    liveModel.img = model.img;
    XMLiveViewController *xmVC = [[XMLiveViewController alloc] init];
    xmVC.liveAddressStr = model.address;
    xmVC.liveModle = liveModel;
    xmVC.title = model.title;
    xmVC.systemMessage = _systemMessage;
    [self.navigationController pushViewController:xmVC animated:NO];
}



@end
