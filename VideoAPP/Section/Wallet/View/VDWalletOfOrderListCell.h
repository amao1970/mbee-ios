//
//  VDWalletOfOrderListCell.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VDWalletOfOrderListCell : JXTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *stateLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;

@end

NS_ASSUME_NONNULL_END
