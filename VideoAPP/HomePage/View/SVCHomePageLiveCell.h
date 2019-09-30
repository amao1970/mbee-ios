//
//  SVCHomePageLiveCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCLiveModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SVCHomePageLiveCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UIButton *enter;
@property (strong, nonatomic) IBOutlet UIView *bgView;
-(void)updateLiveWithModel:(SVCLiveModel*)model;
@end

NS_ASSUME_NONNULL_END
