//
//  SVCHomePageSearchBar.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVCHomePageSearchBar : JXView

@property (strong, nonatomic) IBOutlet UIButton *type;
@property (strong, nonatomic) IBOutlet UIButton *search;
@property (strong, nonatomic) IBOutlet UITextField *textFeild;
@property (strong, nonatomic) IBOutlet UIView *bgView;


@end

@interface SVCHomePageSmallSearchBar : JXView

@property (strong, nonatomic) IBOutlet UIButton *type;
@property (strong, nonatomic) IBOutlet UIButton *search;
@property (strong, nonatomic) IBOutlet UITextField *textFeild;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIButton *back;


@end

NS_ASSUME_NONNULL_END
