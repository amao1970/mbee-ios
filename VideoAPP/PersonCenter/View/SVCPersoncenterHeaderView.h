//
//  SVCPersoncenterHeaderView.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SVCPersoncenterHeaderViewProtocol <NSObject>

- (void)LoginClick;

@end

@interface SVCPersoncenterHeaderView : UITableViewHeaderFooterView

- (void)setupHeaderUI:(BOOL)ret;

@property (nonatomic , assign) id <SVCPersoncenterHeaderViewProtocol> Vdelegate;
@end
