//
//  SVCVideoDetailViewController.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCVideoDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCVideoDetailViewController : SVCBaseViewController

@property (nonatomic, strong) SVCVideoDetailModel *videoInfo;
@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, assign) BOOL isPreview;
@property (nonatomic, strong) NSString *tiepianLink;

@end

NS_ASSUME_NONNULL_END
