//
//  SVCTVLiveLeftCell.h
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVCTVLiveLeftCell : UITableViewCell

@property(nonatomic, copy) NSString *nameString; /**<<#属性#> */

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
