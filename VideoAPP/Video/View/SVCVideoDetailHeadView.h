//
//  SVCVideoDetailHeadView.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//



#import "JXView.h"
#import "JXVideoInfoModel.h"
#import "SKTagView.h"
#import "SVCLiveToolBtn.h"
#import <SDWebImage/FLAnimatedImageView+WebCache.h>



NS_ASSUME_NONNULL_BEGIN

@interface SVCVideoDetailHeadView : JXView

@property (nonatomic, strong) JXVideoInfoModel *videoDetailInfo;

@property (nonatomic, strong) NSDictionary *bannerInfo;
@property (strong, nonatomic) IBOutlet SVCLiveToolBtn *shareBtn;
@property (strong, nonatomic) IBOutlet UIImageView *advBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
@property (strong, nonatomic) IBOutlet UILabel *playNum;
@property (strong, nonatomic) IBOutlet SKTagView *tagView;
@property (strong, nonatomic) IBOutlet SVCLiveToolBtn *downloadBtn;
@property (strong, nonatomic) IBOutlet UIButton *close_advImg;
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLab;
@property (strong, nonatomic) IBOutlet UILabel *fansLab;

@property (strong, nonatomic) IBOutlet FLAnimatedImageView *advImg;

@property (strong, nonatomic) IBOutlet UIView *line;
@property (strong, nonatomic) IBOutlet UIButton *userBtn;
@property (strong, nonatomic) IBOutlet SVCLiveToolBtn *collection;
@property (strong, nonatomic) IBOutlet UIView *subtitleBgView;
@property (strong, nonatomic) IBOutlet UIButton *show;

-(void)setUpShow;

@end

NS_ASSUME_NONNULL_END
