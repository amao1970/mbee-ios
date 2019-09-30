//
//  VDWalletOfGetMoneyVC.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDWalletOfGetMoneyView : JXView

@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *payType;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIView *payAccount;
@property (strong, nonatomic) IBOutlet UILabel *balanceLab;
@property (strong, nonatomic) IBOutlet UILabel *minMoney;
@property (strong, nonatomic) IBOutlet UIButton *commit;
@property (strong, nonatomic) IBOutlet UITextField *moneyTF;


@end

NS_ASSUME_NONNULL_END
