//
//  VDWalletMainView.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDWalletMainView : JXView
@property (strong, nonatomic) IBOutlet UIView *getMoneyView;
@property (strong, nonatomic) IBOutlet UIView *orderList;
@property (strong, nonatomic) IBOutlet UIView *setAccount;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;

@end

NS_ASSUME_NONNULL_END
