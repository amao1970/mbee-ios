//
//  SVCbuttonClickCell.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SVCbuttonClickCellProtocol <NSObject>

- (void)LogoutClick;

@end

@interface SVCbuttonClickCell : UITableViewCell

@property (nonatomic , assign) id <SVCbuttonClickCellProtocol> Vdelegate;


@end
