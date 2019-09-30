//
//  SVCrechargeView.h
//  SmartValleyCloudSeeding
//
//  Created by 鹏张 on 2018/6/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SVCrechargeViewProtocol <NSObject>

- (void)rechargeViewDidclick:(NSInteger) tag;

@end
@interface SVCrechargeView : UIView

- (void)setrechargeLabtext:(NSString *)title;

@property (nonatomic , assign) id <SVCrechargeViewProtocol> Vdelegate;

@end
