//
//  SVCVideoListCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"
#import "SKTagView.h"
#import "JXVideoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCVideoListCell : JXTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *attLab;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet SKTagView *tagView;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
@property (strong, nonatomic) JXVideoListModel *modelInfo;
@property (copy) void(^tagSelect)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
