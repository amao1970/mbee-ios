//
//  SVCShareView.h
//  SmartValleyCloudSeeding
//
//  Created by Mac on 2018/8/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVCShareView;
@protocol SVCShareViewDelegate<NSObject>

@optional
- (void)shareView:(SVCShareView *)shareView didClickButtonWithIndex:(NSInteger)index;

@end

@interface SVCShareView : UIView

@property (weak, nonatomic) id<SVCShareViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthCOns;

+ (instancetype)shareView;

@end
