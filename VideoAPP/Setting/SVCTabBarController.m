//
//  SVCTabBarController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTabBarController.h"
#import "SVCNavigationController.h"
#import "SVCLoginViewController.h"

@interface SVCTabBarController ()<UITabBarControllerDelegate>
@end

@implementation SVCTabBarController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]] ;
    
    self.tabBar.tintColor= [UIColor HxIsWaterBlueColor];
    self.delegate = self;
    [self.tabBar setClipsToBounds:YES];
//    self.tabBar.delegate = self;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    
    backView.backgroundColor = [UIColor colorWithHexString:@"d9d9d9" andAlpha:1];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    self.tabBar.translucent=NO;
//    [self initWithtabBar:@"SVCLiveViewController" title:@"直播" selectedImage:@"live_xz" unselectedImage:@"live_wxz"];
    [self initWithtabBar:@"SVCHomePageViewController" title:@"首页" selectedImage:@"live_xz" unselectedImage:@"live_wxz"];
    [self initWithtabBar:@"SVCVideoViewController" title:@"影视" selectedImage:@"yunbo_xz" unselectedImage:@"yunb_wxz" ];
    [self initWithtabBar:@"SVCImageViewController" title:@"图片" selectedImage:@"image_xz" unselectedImage:@"image_wxz" ];
    [self initWithtabBar:@"SVCOriginateNovelViewController" title:@"小说" selectedImage:@"yingshi__xz" unselectedImage:@"yingshi_wxz" ];//
    [self initWithtabBar:@"SVCPersonCenterViewController" title:@"我的" selectedImage:@"wode_xz" unselectedImage:@"wode_wxz" ];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    for (NSInteger i = 0; i < self.tabBar.subviews.count; i++) {
        UIView *view = self.tabBar.subviews[i];
        NSLog(@"view.frame = %@, class = %@", NSStringFromCGRect(view.frame), NSStringFromClass(view.class));
    }
    NSLog(@"---%@----",NSStringFromCGSize(size));
}

- (void)initWithtabBar:(NSString *)viewControlName title:(NSString *)title selectedImage:(NSString *)imageName unselectedImage:(NSString *)unselectedimage {
    Class class = NSClassFromString(viewControlName);
    UIViewController *control = [[class alloc] init];
    control.title = title;
//    [[UITabBarItemappearance] setTitleTextAttributes:   [NSDictionarydictionaryWithObjectsAndKeys:[UIColorredColor],UITextAttributeTextColor,nil]forState:UIControlStateSelected];
   
    control.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage loadImageWithImgName:unselectedimage] selectedImage:[UIImage loadImageWithImgName:imageName]];
     [control.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hexStringToColor:@"f75858"],UITextAttributeTextColor,nil] forState:(UIControlState)UIControlStateSelected];
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:control];
    [self addChildViewController:nav];
  
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]){
         SVCCurrUser *user = [SVCUserInfoUtil mGetUser];
        NSString *token =  [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
        if (user.uid.length < 1 ||  token.length < 1) {
            SVCLoginViewController *logVC = [[SVCLoginViewController alloc] init];
                        SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
                        [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }else{
            return YES;
            }
    } else
    {
        return YES;
        
    }
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
