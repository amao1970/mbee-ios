//
//  SVCLiveTypeCell.h
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVCLiveModel;

@interface SVCLiveTypeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *numButton;

@property (weak, nonatomic) IBOutlet UILabel *liveTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewICon;

@property(nonatomic,strong) SVCLiveModel *liveModel;


@end
