//
//  SVCSearchHotListView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCSearchHotListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCSearchHotListView : UICollectionView

@property (nonatomic, strong) NSMutableArray<SVCSearchHotListModel*> *dataAry;

@property (copy) void(^didSelectBlack)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
