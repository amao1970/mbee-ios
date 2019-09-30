//
//  SVCHomePageImgCell.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/6.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "JXTableViewCell.h"
#import "SVCHomePageModel.h"
#import "SVCImageDetailModel.h"
#import "SVCNovelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVCHomePageImgCell : JXTableViewCell
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgAry;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
-(void)updateHomePageWithMode:(SVCHomePageModel*)model;
-(void)updateImageWithMode:(SVCImageDetailModel*)model;
-(void)updateNovelWithMode:(SVCNovelModel*)model;
@end

@interface SVCHomePageImgOfTypeOneImgCell : JXTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
-(void)updateHomePageWithMode:(SVCHomePageModel*)model;
-(void)updateImageWithMode:(SVCImageDetailModel*)model;
-(void)updateNovelWithMode:(SVCNovelModel*)model;
@end

@interface SVCHomePageImgOfTypeNoImgCell : JXTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLab;
-(void)updateHomePageWithMode:(SVCHomePageModel*)model;
-(void)updateNovelWithMode:(SVCNovelModel*)model;
@end

NS_ASSUME_NONNULL_END
