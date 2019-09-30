//
//  SVCLoginViewController.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/8.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol SVCLoginViewControllerProtocol <NSObject>
//
//- (void)confing;
//
//@end
@interface SVCLoginViewController : UIViewController

@property (nonatomic , copy )NSString *type;

//@property (nonatomic , assign) id <SVCLoginViewControllerProtocol> Vdelegate;

@property (nonatomic,copy) void(^adLoginClick)(NSInteger index);
@end
