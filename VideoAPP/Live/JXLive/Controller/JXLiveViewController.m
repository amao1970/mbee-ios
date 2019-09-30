//
//  JXLiveViewController.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXLiveViewController.h"
#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"
#import "DLCustomSlideView.h"
#import "SVCNovelModel.h"
#import "SVCImageTableViewController.h"
#import "SVCRecommendVC.h"
#import "SVCAllLiveViewController.h"
#import "JXPlayBackViewController.h"

@interface JXLiveViewController ()<DLCustomSlideViewDelegate>

@property(nonatomic, weak) DLScrollTabbarView *tabbar; /**<<#属性#> */
@property(nonatomic, weak) DLCustomSlideView *slideView; /**<<#属性#> */
//@property(nonatomic, strong) NSMutableArray *dataList; /**<<#属性#> */
@property(nonatomic, strong) NSMutableArray *itemList; /**<<#属性#> */

@end

@implementation JXLiveViewController

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
    CGRect rect  = CGRectMake(0, Nav_HEIGHT - 44, SCREEN_WIDTH, SCREEN_HEIGHT - Knavheight - kTabbarHeight+44 );
    DLCustomSlideView *slideView = [[DLCustomSlideView alloc] initWithFrame:rect];
    slideView.backgroundColor = [UIColor whiteColor];
    slideView.delegate = self;
    self.slideView = slideView;
    [self.view addSubview:slideView];
    [self setupSlideView];
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
    NSArray *tmpAry = @[@"推荐",@"全部主播",@"精彩回放"];
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:tmpAry.count];
    DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(JXWidth(20), 0, SCREEN_WIDTH - JXWidth(45), GetHeightByScreenHeigh(45))];
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(-tabbar.x, GetHeightByScreenHeigh(45) - 1, SCR_WIDTH, 1)];
    marginView.backgroundColor = SVCMarginColorf5;
    [tabbar addSubview:marginView];
    tabbar.tabItemNormalColor = SVCTextColor46;
    tabbar.tabItemSelectedColor = SVCMainColor;
    tabbar.tabItemNormalFontSize = 12.0f;
    tabbar.tabItemSelectedFontSize = 18.0f;
    tabbar.trackColor = SVCMainColor;
    _itemList = [NSMutableArray array];
    
    for (int i=0; i<tmpAry.count; i++) {
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f]};
        CGSize size = [tmpAry[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 45) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        DLScrollTabbarItem * item = [DLScrollTabbarItem itemWithTitle:tmpAry[i] width:size.width + 20];
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
    [self.slideView addSubview:line];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.frame = CGRectMake(SCR_WIDTH - JXWidth(45), 1, JXWidth(45), GetHeightByScreenHeigh(45)-2);
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setImage:[UIImage imageNamed:@"search_nav_bar"] forState:UIControlStateNormal];
    [searchBtn setTintColor:SVCMainColor];
    [searchBtn addTarget:self action:@selector(pushToSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.slideView addSubview:searchBtn];
}

-(void)pushToSearch{
    SVCSearchViewController *targent = [[SVCSearchViewController alloc] init];
    targent.typeStr = @"0";
    [self.navigationController pushViewController:targent animated:YES];
}

- (void)setupNav{
    self.navigationItem.title = @"直播";
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
    if (index == 0) {
        SVCRecommendVC *targent = [[SVCRecommendVC alloc] init];
        return targent;
     }
    else if (index == 1){
        SVCAllLiveViewController *targent = [[SVCAllLiveViewController alloc] init];
        return targent;
    }
    else{
        JXPlayBackViewController *targent = [[JXPlayBackViewController alloc] init];
        return targent;
    }
}
- (void)DLCustomSlideView:(DLCustomSlideView *)sender didSelectedAt:(NSInteger)index{
    //    NSLog(@"didSelectedAt == %d",index);
}

- (void)dealloc{
    NSLog(@"界面销毁");
}

@end
