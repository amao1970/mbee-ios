//
//  JXFocusImageView.h
//  alias_hemeiOS
//
//  Created by admxjx on 2018/1/30.
//  Copyright © 2018年 Hemefin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPagedFlowView.h"
@class JXAdvModel;

@protocol JXFocusImageViewDelegate <NSObject>

@optional
-(void)JXFocusImageViewClick_img:(NSInteger)subIndex;

@end

@interface JXFocusImageView : NewPagedFlowView
@property (nonatomic, strong) NSMutableArray<JXAdvModel *> *dataAry;
-(void)reloadWithModel:(NSMutableArray<JXAdvModel *> *)dataAry;
@property (nonatomic, weak) id<JXFocusImageViewDelegate> JXDelegate;

@end
