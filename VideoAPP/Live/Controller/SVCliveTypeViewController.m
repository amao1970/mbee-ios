//
//  SVCliveTypeViewController.m
//  SmartValleyCloudSeeding
//
//  Created by  on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCliveTypeViewController.h"
#import "SVCRechargeVC.h"
#import "SVCNavigationController.h"
#import "SVCLoginViewController.h"
#import "BKNetworkHelper.h"
#import "SVCLiveModel.h"
#import "SVCLiveTypeCell.h"
#import "XMLiveViewController.h"
#import "MBProgressHUD+BK.h"
#import "SVCCollectionViewCell.h"
#import "SVCIndeModel.h"
#import "SVCliveViewCell.h"
#import <MJRefresh.h>
#import "SVCOnbordModel.h"

@interface SVCliveTypeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *ImageArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,copy) NSString *noticeStr;

@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */

/** 提示系统信息 */
@property (nonatomic,copy) NSMutableArray *systemMessageArt;

@property (nonatomic,copy) NSDictionary *systemMessage;

@end

@implementation SVCliveTypeViewController

-(NSMutableArray *)ImageArray{
    if (!_ImageArray) {
        _ImageArray = [[NSMutableArray alloc]init];
    }
    return _ImageArray;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getliveData];
    [self getOnbordData];
}

-(void)getOnbordData{
    [SVCCommunityApi getOnbordCategoryWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *jsonArr) {
        if (code == 0) {
            if ([jsonArr isKindOfClass:[NSDictionary class]]) {
                if (jsonArr) {
                    _systemMessage = jsonArr;// [SVCOnbordModel mj_objectArrayWithKeyValuesArray:jsonArr];
                }else{
                    NSLog(@"没有分类数据");
                }
            }
        }
    } andfail:^(NSError *error) {
        
    }];
}

-(void)getliveData{
    WS(weakSelf);
    BKNetworkHelper *help = [BKNetworkHelper shareInstance];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.liveUrlStr forKey:@"name"];
    [WsHUD showHUDWithLabel:@"正在拼命加载中..." modal:NO timeoutDuration:20];
    [help POST:[NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/live/anchors"] Parameters:dict Success:^(id responseObject) {
        [WsHUD hideHUD];
        NSLog(@"%@ %@ %@",dict,responseObject,[NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/live/anchors"])
        if ([weakSelf.collectionView.mj_header isRefreshing]) {
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        NSArray *arr = responseObject[@"data"][@"lists"];
        if (weakSelf.dataArray.count > 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        for (NSDictionary *dict in arr) {
            SVCLiveModel *model = [SVCLiveModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
    } Failure:^(NSError *error) {
        if ([weakSelf.collectionView.mj_header isRefreshing]) {
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        [WsHUD hideHUD];
        [self.view toastShow:@"请求数据出错"];
    }];
}
- (void)reflashDatas
{
    [self getliveData];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-69) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"SVCLiveTypeCell" bundle:nil] forCellWithReuseIdentifier:@"SVCLiveTypeCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SVCliveViewCell" bundle:nil] forCellWithReuseIdentifier:@"XMtopCell"];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_collectionView.mj_header beginRefreshing];
            [self reflashDatas];
        }];
        
//        [_collectionView registerClass:[SVCliveViewCell class] forCellWithReuseIdentifier:@"XMtopCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SVCliveViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMtopCell" forIndexPath:indexPath];
        [cell.imageViewICon sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:[UIImage imageNamed:@"默认图"]];
        [cell.numButton setTitle:[NSString stringWithFormat:@"%ld",self.dataArray.count] forState:0];
//        self.topTitle = @"天明";
        NSMutableAttributedString *attrString  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@直播平台",self.topTitle]];
        NSUInteger length = [attrString length];
        [attrString addAttribute:NSFontAttributeName value:kFont(15) range:NSMakeRange(0, length)];//设置所有的字体
        [attrString addAttribute:NSFontAttributeName value:kFont(19) range:[[NSString stringWithFormat:@"%@直播平台",self.topTitle] rangeOfString:self.topTitle]];//设置Text这四个字母的字体为粗体
        cell.titleLa.attributedText = attrString;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        SVCLiveTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCLiveTypeCell" forIndexPath:indexPath];
        SVCLiveModel *model = self.dataArray[indexPath.item];
        cell.liveModel = model;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        WS(weakSelf);
        if (self.isSelectedCell == NO) {
            self.isSelectedCell = YES;
            BKNetworkHelper *hepl = [BKNetworkHelper shareInstance];
            NSString *xmurl = [NSString stringWithFormat:@"%@mobile/index/checkUser",BASE_API];
            [hepl POST:xmurl Parameters:nil Success:^(id responseObject) {
                
                NSString *strMsg = [responseObject objectForKey:@"msg"];
                if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                    NSDictionary *dic = [responseObject objectForKey:@"data"];
                    NSString *appmsg = [dic objectForKey:@"app_sys_msg"];
                    [weakSelf pusuToVc:indexPath.item and:appmsg];
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
                weakSelf.isSelectedCell = NO;
                [weakSelf.view toastShow:netFailString];
            }];
            
        }
       
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
    SVCLiveModel *model = self.dataArray[index];
    XMLiveViewController *xmVC = [[XMLiveViewController alloc] init];
    xmVC.liveAddressStr = model.play_url;
    xmVC.liveModle = model;
    xmVC.title = model.title;
    xmVC.systemMessage = _systemMessage;
    [self.navigationController pushViewController:xmVC animated:NO];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(kScreenWidth, 150);
    }
    return CGSizeMake(kScreenWidth/2.0-10, 150);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(15, 5, 15, 5);//分别为上、左、下、右
}

-(void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
