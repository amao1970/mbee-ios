//
//  SVCVideoDetailTableView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXVideoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SVCVideoDetailTableViewDelegate <NSObject>

@optional
-(void)SVCVideoDetailTableViewDidSelect:(NSIndexPath*)indexPath;
-(void)SVCVideoDetailTableViewDidSelect:(NSIndexPath*)indexPath Tag:(NSInteger)tag;

@end

@interface SVCVideoDetailTableView : UITableView

@property (nonatomic, weak) id<SVCVideoDetailTableViewDelegate> JXDelegate;
@property (nonatomic, strong) NSMutableArray<JXVideoListModel*> *dataAry;

@end

NS_ASSUME_NONNULL_END
