//
//  SVCHomePageTopView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVCHomePageTopView : UIView

@property (nonatomic,copy) NSString *notice;

@property (nonatomic,strong) NSArray *imageArr;

@property (nonatomic,copy) void(^adListClick)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
