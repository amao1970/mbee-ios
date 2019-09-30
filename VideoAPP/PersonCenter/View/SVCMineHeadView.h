//
//  SVCMineHeadView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/2/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXView.h"
#import "SVCMineToolBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCMineHeadView : JXView

@property (strong, nonatomic) IBOutlet SVCMineToolBtn *rechargeBtn;
@property (strong, nonatomic) IBOutlet SVCMineToolBtn *shareBtn;
@property (strong, nonatomic) IBOutlet SVCMineToolBtn *delegateBtn;
@property (strong, nonatomic) IBOutlet SVCMineToolBtn *advBtn;

@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UIButton *renewalBtn;
@property (strong, nonatomic) IBOutlet UILabel *unLogin;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UIButton *incomeLab;
@property (strong, nonatomic) IBOutlet UIButton *worksLab;
@property (strong, nonatomic) IBOutlet UIButton *FocusLab;
@property (strong, nonatomic) IBOutlet UIButton *collectionLab;
@property (strong, nonatomic) IBOutlet UILabel *income;
@property (strong, nonatomic) IBOutlet UILabel *works;
@property (strong, nonatomic) IBOutlet UILabel *focus;
@property (strong, nonatomic) IBOutlet UILabel *collection;
@property (strong, nonatomic) IBOutlet UIButton *settingBtn;


-(void)updateUIWithLogin:(BOOL)loginSuccess;

@end

NS_ASSUME_NONNULL_END
