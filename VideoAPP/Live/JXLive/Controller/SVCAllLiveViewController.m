//
//  SVCAllLiveViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/16.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCAllLiveViewController.h"
#import "SVCAllLiveCell.h"
#import "JXAllLiveModel.h"
#import "SVCRechargeVC.h"
#import "SVCLiveModel.h"
#import "XMLiveViewController.h"

@interface SVCAllLiveViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>
{
    WSLWaterFlowLayout * _flow;
}
@property (nonatomic, strong) NSMutableArray<JXAllLiveModel*> *dataAry;
@property(nonatomic, assign) BOOL isSelectedCell; /**<<#属性#> */
@property (nonatomic,copy) NSDictionary *systemMessage;
@property (nonatomic, strong)UICollectionView * collectionView;
@end

@implementation SVCAllLiveViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isSelectedCell = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _flow = [[WSLWaterFlowLayout alloc] init];
    _flow.delegate = self;
    _flow.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_HEIGHT, self.view.frame.size.width, SCR_HIGHT - Nav_HEIGHT -Tabbar_HEIGHT ) collectionViewLayout:_flow];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //注册Item
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SVCAllLiveCell class]) bundle:nil] forCellWithReuseIdentifier:@"SVCAllLiveCell"];
    
    WS(weakSelf)
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header beginRefreshing];
        [weakSelf getNetData];
        [weakSelf getOnbordData];
    }];
    [self.view addSubview:self.collectionView];
    
    [self refreshLayout];
    
    [self getNetData];
    [self getOnbordData];
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
    [WsHUD showHUDWithLabel:@"加载数据..." modal:YES timeoutDuration:20.0];
    [SVCCommunityApi getAllLiveWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSArray *arr = JSON[@"lists"];
            self.dataAry = [JXAllLiveModel arrayOfModelsFromDictionaries:arr error:nil];
            [weakSelf refreshLayout];
        }else{
            [weakSelf.view toastShow:msg];
        }
        [WsHUD hideHUD];
        [self.collectionView.mj_header endRefreshing];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)refreshLayout{
    _flow.collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCR_HIGHT - Nav_HEIGHT - Tabbar_HEIGHT);
    [_flow.collectionView  reloadData];
}

#pragma mark - WSLWaterFlowLayoutDelegate
//返回每个item大小
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    JXAllLiveModel *model = [self.dataAry objectAtIndex:indexPath.row];
    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
        return model.imageSize;
    }else{
        float W = (SCR_WIDTH-15)/2.f;
        NSInteger intW = W/2;
        float H = arc4random() % intW;
        H+=W;
        model.imageSize = CGSizeMake(W, H);
        return model.imageSize;
    }
    return CGSizeMake(150, 150);
}

/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}
/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - UICollectionView数据源

//组个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//组内成员个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataAry.count;
}

// 返回每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXAllLiveModel *model = self.dataAry[indexPath.row];
    SVCAllLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCAllLiveCell" forIndexPath:indexPath];
    cell.title.text = model.title;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"默认图"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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
                [weakSelf pusuToVc:indexPath.row and:appmsg];
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
    JXAllLiveModel *model = self.dataAry[index];
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
