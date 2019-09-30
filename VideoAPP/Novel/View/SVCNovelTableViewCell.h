//
//  SVCNovelTableViewCell.h
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVCNovelTableViewCell : UITableViewCell
@property(nonatomic, copy) NSString *novelName; /**<<#属性#> */

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
