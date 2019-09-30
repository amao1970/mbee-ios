//
//  SVCHomePageLiveView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCLiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SVCHomePageLiveViewDelegate <NSObject>

@optional
-(void)SVCHomePageLiveViewDidSelect:(NSInteger)index;

@end

@interface SVCHomePageLiveView : UIView

@property (strong, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic, weak) id<SVCHomePageLiveViewDelegate> JXDelegate;
@property (nonatomic, strong) NSMutableArray<SVCLiveModel*> *dataAry;

@end

NS_ASSUME_NONNULL_END
