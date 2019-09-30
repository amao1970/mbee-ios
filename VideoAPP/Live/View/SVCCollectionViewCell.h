//
//  SVCCollectionViewCell.h
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SVCCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) NSString *notice;

@property (nonatomic,strong) NSArray *imageArr;

@property (nonatomic,copy) void(^adListClick)(NSInteger index);

@end
