//
//  VDWalletOfBindCardView.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/6.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VDWalletOfBindCardView : JXView

@property (strong, nonatomic) IBOutlet UIButton *commit;
@property (strong, nonatomic) IBOutlet UIButton *qrImgBtn;
@property (strong, nonatomic) IBOutlet UITextField *nameLab;
@property (strong, nonatomic) IBOutlet UIButton *alipayBtn;
@property (strong, nonatomic) IBOutlet UIButton *wechatPay;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIView *defaultView;

@end

NS_ASSUME_NONNULL_END
