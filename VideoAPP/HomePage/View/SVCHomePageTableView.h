//
//  SVCHomePageTableView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/6.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCHomePageModel.h"
#import "SVCHomePageLiveView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SVCHomePageTableViewDelegate <NSObject>

@optional
-(void)SVCHomePageTableViewDidSelect:(NSIndexPath*)indexPath;
-(void)SVCHomePageLiveDidSelect:(NSInteger)index;
@end

@interface SVCHomePageTableView : UITableView

@property (nonatomic, weak) id<SVCHomePageTableViewDelegate> JXDelegate;
@property (nonatomic,strong) SVCHomePageLiveView *liveView;
@property (nonatomic, assign) BOOL hiddenLiveView;
-(void)reloadDataWithArray:(NSArray<SVCHomePageModel*> *)array;

@end

NS_ASSUME_NONNULL_END
