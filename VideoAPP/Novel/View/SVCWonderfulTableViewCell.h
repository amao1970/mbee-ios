//
//  SVCWonderfulTableViewCell.h
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVCWonderfulVideoModel;

@interface SVCWonderfulTableViewCell : UITableViewCell

@property(nonatomic, strong) SVCWonderfulVideoModel *videoModel; /**<<#属性#> */

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
