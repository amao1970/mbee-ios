//
//  VDKindVC.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VDKindVC : SVCBaseViewController

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *cate;
@property (nonatomic, strong) NSString *cateID;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, assign) BOOL hiddenHeadView;

@end

NS_ASSUME_NONNULL_END
