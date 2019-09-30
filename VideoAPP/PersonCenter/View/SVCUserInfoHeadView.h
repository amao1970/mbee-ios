//
//  SVCUserInfoHeadView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCUserInfoHeadView : JXView
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *rechargeBtn;

@property (strong, nonatomic) IBOutlet UIView *monthView;
@property (strong, nonatomic) IBOutlet UIView *quarterView;
@property (strong, nonatomic) IBOutlet UIView *halfYearView;
@property (strong, nonatomic) IBOutlet UIView *yearView;
@property (strong, nonatomic) IBOutlet UIView *servierView;

@property (strong, nonatomic) IBOutlet UILabel *monthOnLineView;
@property (strong, nonatomic) IBOutlet UILabel *quarterOnLineView;
@property (strong, nonatomic) IBOutlet UILabel *halfYearOnLineView;
@property (strong, nonatomic) IBOutlet UILabel *yearOnLineView;

@property (strong, nonatomic) IBOutlet UILabel *monthMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *quarterMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *halfYearMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *yearMoneyLab;

@property (strong, nonatomic) IBOutlet UILabel *serverLab;

@end

NS_ASSUME_NONNULL_END
