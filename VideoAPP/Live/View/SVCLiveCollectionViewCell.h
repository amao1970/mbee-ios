//
//  SVCLiveCollectionViewCell.h
//  SmartValleyCloudSeeding
//
//  Created by chen on 2018/6/9.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVCIndeModel,SVCLiveModel;

@interface SVCLiveCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *danmuButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;

@property (weak, nonatomic) IBOutlet UILabel *nikeLabel;

@property (weak, nonatomic) IBOutlet UIButton *LiveNumLabel;

@property (nonatomic,strong) SVCIndeModel *indexModel;

@property (nonatomic,strong) SVCLiveModel *LiveModel;

@end
