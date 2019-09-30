//
//  UIVIPMoviesViewController.h
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    VIPMovies,
    TVLive
}WebViewType;

@interface UIVIPMoviesViewController : SVCBaseViewController

@property(nonatomic, assign) WebViewType type; /**<<#属性#> */

- (instancetype)initWithUrl:(NSString *)VIPMoviesUrl type:(WebViewType)type;
@property(nonatomic, copy) NSString *VIPMoviesUrl; /**< */

@end
