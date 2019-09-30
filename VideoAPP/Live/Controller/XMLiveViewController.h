//
//  XMLiveViewController.h
//  SmartValleyCloudSeeding
//
//  Created by  on 2018/6/14.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCOnbordModel.h"
@class SVCLiveModel;

@interface XMLiveViewController : SVCBaseViewController

@property (nonatomic,assign) BOOL isReplay;
@property (nonatomic,copy) NSString *liveAddressStr;

@property (nonatomic,strong) SVCLiveModel *liveModle;
/** 提示系统信息 */
@property (nonatomic,copy) NSArray<NSString*>*systemMessageArt;
@property (nonatomic,copy) NSDictionary*systemMessage;
@end
