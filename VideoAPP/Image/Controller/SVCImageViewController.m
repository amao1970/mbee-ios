//
//  SVCImageViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/4.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCImageViewController.h"
#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"
#import "DLCustomSlideView.h"
#import "SVCNovelModel.h"
#import "SVCImageTableViewController.h"
@interface SVCImageViewController ()<DLCustomSlideViewDelegate>

@property(nonatomic, weak) DLScrollTabbarView *tabbar; /**<<#属性#> */
@property(nonatomic, weak) DLCustomSlideView *slideView; /**<<#属性#> */
@property(nonatomic, strong) NSMutableArray *dataList; /**<<#属性#> */
@property(nonatomic, strong) NSMutableArray *itemList; /**<<#属性#> */

@end

@implementation SVCImageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect  = CGRectMake(0, Nav_HEIGHT - 44, SCREEN_WIDTH, SCREEN_HEIGHT - Knavheight - kTabbarHeight + 44 );
    DLCustomSlideView *slideView = [[DLCustomSlideView alloc] initWithFrame:rect];
    slideView.backgroundColor = [UIColor whiteColor];
    slideView.delegate = self;
    self.slideView = slideView;
    [self.view addSubview:slideView];
    [SVCCommunityApi getImageCategoryWithParams:nil BlockSuccess:^(NSInteger code, NSString *msg, NSArray *jsonArr) {
        if (code == 0) {
            if ([jsonArr isKindOfClass:[NSArray class]]) {
                if (jsonArr.count > 0) {
                    _dataList = [SVCNovelModel mj_objectArrayWithKeyValuesArray:jsonArr];
                    [self setupSlideView];
                }else{
                    NSLog(@"没有分类数据");
                }
            }
        }
    } andfail:^(NSError *error) {
        
    }];
//    [self setUpLeftBtn];
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
    SVCHomePageViewController *targent = [[SVCHomePageViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)setupSlideView{
    
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:_dataList.count];
    DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - JXWidth(45), GetHeightByScreenHeigh(45))];
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, GetHeightByScreenHeigh(45) - 1, SCR_WIDTH, 1)];
    marginView.backgroundColor = SVCMarginColorf5;
    [tabbar addSubview:marginView];
    tabbar.tabItemNormalColor = SVCTextColor46;
    tabbar.tabItemSelectedColor = SVCMainColor;
    tabbar.tabItemNormalFontSize = 12.0f;
    tabbar.tabItemSelectedFontSize = 18.0f;
    tabbar.trackColor = SVCMainColor;
    _itemList = [NSMutableArray array];
    for (int i=0; i<_dataList.count; i++) {
        SVCNovelModel *model = [_dataList objectAtSafeIndex:i];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f]};
        CGSize size = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 45) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        DLScrollTabbarItem * item = [DLScrollTabbarItem itemWithTitle:model.title width:size.width + 20];
        [_itemList addObject:item];
    }
    tabbar.tabbarItems = _itemList;
    self.slideView.tabbar = tabbar;
    self.slideView.cache = cache;
    self.slideView.baseViewController = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.slideView setup];
    self.slideView.selectedIndex = 0;
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(SCR_WIDTH - JXWidth(45) + 3, 15, JXWidth(45), GetHeightByScreenHeigh(45)-30);
    line.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:1];
    line.layer.shadowColor = [UIColor hexStringToColor:@"a5a5a5"].CGColor;
    line.layer.shadowOffset = CGSizeMake(-5, 0);
    line.layer.shadowRadius = 3;
    line.layer.shadowOpacity = 1;
    [tabbar addSubview:line];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.frame = CGRectMake(SCR_WIDTH - JXWidth(45), 1, JXWidth(45), GetHeightByScreenHeigh(45)-2);
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setImage:[UIImage imageNamed:@"search_nav_bar"] forState:UIControlStateNormal];
    [searchBtn setTintColor:SVCMainColor];
    [searchBtn addTarget:self action:@selector(pushToSearch) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:searchBtn];
}

-(void)pushToSearch{
    SVCSearchViewController *targent = [[SVCSearchViewController alloc] init];
    [self.navigationController pushViewController:targent animated:YES];
}

- (void)setupNav{
    self.navigationItem.title = @"图文";
    //    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [backBtn setImage:showImage(@"icon_fanhui") forState:0];
    //    backBtn.frame = CGRectMake(0, 15, 40, 30);
    //    [backBtn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //    self.navigationItem.leftBarButtonItem = item;
}

-(void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender{
    return _itemList.count;
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index{
    SVCNovelModel *model = [_dataList objectAtSafeIndex:index];
    SVCImageTableViewController *vc = [[SVCImageTableViewController alloc] initWithCategoryID:model.ID];
    return vc;
}
- (void)DLCustomSlideView:(DLCustomSlideView *)sender didSelectedAt:(NSInteger)index{
    //    NSLog(@"didSelectedAt == %d",index);
}

- (void)dealloc{
    NSLog(@"界面销毁");
}


@end
