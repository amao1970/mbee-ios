//
//  SVCTextReadViewController.h
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCNovelModel.h"

@interface SVCTextReadViewController : SVCBaseViewController
@property (nonatomic, strong) NSArray *imgURLS;
@property (nonatomic,assign) BOOL isImg;
- (instancetype)initWithNovelID:(NSString *)novelID;
@property (nonatomic, strong) SVCNovelModel *novelModel;
@end
