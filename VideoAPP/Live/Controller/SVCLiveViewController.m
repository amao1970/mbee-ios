//
//  SVCLiveViewController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCLiveViewController.h"
#import <MJRefresh.h>
#import <SDCycleScrollView.h>
#import "SVCLiveCollectionViewCell.h"
#import "BKNetworkHelper.h"
#import "SVCCollectionViewCell.h"
#import "SVCIndeModel.h"
#import "SVCMidCollectionViewCell.h"
#import "SVCLiveModel.h"
#import "SVCliveTypeViewController.h"
#import "SVCLoginViewController.h"
#import "SVCNavigationController.h"
#import "SVCHomePageViewController.h"

#define url_list @"http://47.104.175.130:60/zhibo.php?name=list"
#define url_list_type @"http://47.104.175.130:60/zhibo.php?name"


@interface SVCLiveViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *ImageArray;
//公告
@property (nonatomic,copy) NSString *noticeStr;

@property (nonatomic,strong) NSMutableArray *listArray;

@end

@implementation SVCLiveViewController

-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

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
    self.navigationItem.title = AppName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self liveListData];
//    if (!self.hiddenHomeBtn) {
//        [self setUpLeftBtn];
//    }
}

-(void)setUpLeftBtn{
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setImage:showImage(@"icon_fanhui") forState:0];
    homeBtn.frame = CGRectMake(0, 15, 40, 30);
    [homeBtn addTarget:self action:@selector(pushHomePage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)pushHomePage{
    SVCPersonCenterViewController *targent = [[SVCPersonCenterViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

- (void)enterForeground{
    [self checkUpdate];
}
-(void)getData{
    WS(weakSelf);
    [SVCCommunityApi GetBannerListWithNSDiction:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (weakSelf.dataArray.count > 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (weakSelf.ImageArray.count > 0) {
            [weakSelf.ImageArray removeAllObjects];
        }
        if (code == 0) {
            NSArray *arr = JSON[@"advList"];
            weakSelf.noticeStr = JSON[@"notice"];
            for (NSDictionary *dic in arr) {
                SVCIndeModel *model = [SVCIndeModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArray addObject:model];
                [weakSelf.ImageArray addObject:model.image];
            }
            [weakSelf.collectionView reloadData];
        }else{
            [weakSelf.view toastShow:msg];
        }
        [WsHUD hideHUD];
    } andfail:^(NSError *error) {
        [WsHUD hideHUD];
        [weakSelf.view toastShow:netFailString];
    }];
}
- (void)liveListData{
    WS(weakSelf);
    BKNetworkHelper *help = [BKNetworkHelper shareInstance];
    [help POST:[NSString stringWithFormat:@"%@%@",BASE_API,@"/mobile/live/livelist"] Parameters:nil Success:^(id responseObject) {
        if ([weakSelf.collectionView.mj_header isRefreshing]) {
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        NSArray *arr = responseObject[@"data"][@"lists"];
        if (weakSelf.listArray.count > 0) {
            [weakSelf.listArray removeAllObjects];
        }
        for (NSDictionary *dict in arr) {
            SVCLiveModel *model = [SVCLiveModel mj_objectWithKeyValues:dict];
            [weakSelf.listArray addObject:model];
        }
        [weakSelf.collectionView reloadData];
    } Failure:^(NSError *error) {
        if ([weakSelf.collectionView.mj_header isRefreshing]) {
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        [self.view toastShow:netFailString];
    }];
}
#pragma mark --> 检测版本更新
- (void)checkUpdate
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *param = @{@"version":app_Version,@"type":@2};
    WS(weakSelf);
    [SVCCommunityApi CheckUpdateWithNSDiction:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if ([JSON[@"is_update"] intValue] == 1) {
            [weakSelf showcheckUpdate:JSON[@"download_url"]];
        }
    } andfail:^(NSError *error) {
        
    }];
}
#pragma mark --> 提示是否需要更新
- (void)showcheckUpdate:(NSString *)url
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"强制更新" message:@"有新版本推出,前往更新" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }else{
            [self.view toastShow:@"请在后台设置强制更新地址"];
            [self checkUpdate];
        }
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- kTabbarHeight  - Knavheight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        WS(weakSelf);
        //        _collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        //            [_collectionView.mj_header beginRefreshing];
        //            [weakSelf reflashDatas];
        //        }];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_collectionView.mj_header beginRefreshing];
            [weakSelf reflashDatas];
        }];
        
        [_collectionView registerClass:[SVCCollectionViewCell class] forCellWithReuseIdentifier:@"SVCCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SVCMidCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"midCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SVCLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SVCLiveCollectionViewCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)reflashDatas
{
    [self getData];
    [self liveListData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return self.listArray.count;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SVCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCCollectionViewCell" forIndexPath:indexPath];
        cell.imageArr = self.ImageArray;
        if (self.noticeStr.length==0 || self.noticeStr==nil) {
            //            cell.notice = @"这是一条公告，这是一条公告";
        }else{
            cell.notice = self.noticeStr;
        }
        WS(weakSelf);
        [cell setAdListClick:^(NSInteger index) {
            [weakSelf adLinkClick:index];
        }];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (indexPath.section==1){
        SVCMidCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"midCell" forIndexPath:indexPath];
        cell.numLabel.text = [NSString stringWithFormat:@"共%ld个",(unsigned long)self.listArray.count];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        
        SVCLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCLiveCollectionViewCell" forIndexPath:indexPath];
        SVCLiveModel *model = self.listArray[indexPath.item];
        cell.LiveModel = model;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, kScreenWidth/2.0);
    }else if(indexPath.section == 1){
        return CGSizeMake(kScreenWidth, 50);
    }else{
        return CGSizeMake(kScreenWidth/3, 125);
    }
}

-(void)adLinkClick:(NSInteger)index{
    SVCIndeModel *model = self.dataArray[index];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:model.link]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.link]];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSLog(@"点击了banner图");
    }else if (indexPath.section ==1){
        NSLog(@"点击了直播机构");
    }else{
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        if (token==nil || token.length == 0) {
            //            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请前往登录" preferredStyle:(UIAlertControllerStyleAlert)];
            //            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //
            //            }];
            //            [alertVC addAction:action];
            //            [self presentViewController:alertVC animated:YES completion:nil];
            
            
            SVCLoginViewController *loginVC = [[SVCLoginViewController alloc]init];
            SVCNavigationController *nav = [[SVCNavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        
        [self pusuToVc:indexPath.item];
    }
}

-(void)pusuToVc:(NSInteger)index{
    SVCLiveModel *model = self.listArray[index];
    SVCliveTypeViewController *vc = [[SVCliveTypeViewController alloc]init];
    
    //    NSString *str = [NSString stringWithFormat:@"%@=%@",url_list_type,model.title];
    //    NSString *encodeStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    vc.liveUrlStr = model.name;
    vc.title = model.title;
    vc.topTitle = model.title;
    vc.imageStr = model.img;
    [self.navigationController pushViewController:vc animated:YES];
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
