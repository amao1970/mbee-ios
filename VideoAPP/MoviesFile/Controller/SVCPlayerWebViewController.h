//
//  SVCPlayerWebViewController.h
//  SmartValleyCloudSeeding
//
//  Created by Mac on 2018/8/2.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVCPlayerWebViewController : SVCBaseViewController
@property (copy, nonatomic) NSString *playUrl;
- (instancetype)initWithPlayUrl:(NSString *)playUrl;
@end
