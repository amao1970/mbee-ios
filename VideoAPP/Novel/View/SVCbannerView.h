//
//  SVCbannerView.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SVCBannerProtocol <NSObject>

- (void)bannerDidclick:(NSInteger) tag;

@end
@interface SVCbannerView : UIView

- (void)setbannerImage:(NSString *)imageName;

@property (nonatomic , assign) id <SVCBannerProtocol> Vdelegate;

@end
