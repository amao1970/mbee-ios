//
//  VDKindHeadView.h
//  VideoAPP
//
//  Created by admxjx on 2019/5/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VDKindHeadView : UIView

@property (nonatomic, strong) NSMutableArray *sortList;
@property (nonatomic, strong) NSMutableArray *kindList;
@property (nonatomic, strong) NSMutableArray *tagList;

@property (nonatomic, strong) NSString* sortString;
@property (nonatomic, strong) NSString* kindString;
@property (nonatomic, strong) NSString* tagString;

@property (copy) void(^sortblock)(NSInteger tag);
@property (copy) void(^kindblock)(NSInteger tag);
@property (copy) void(^tagsblock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
