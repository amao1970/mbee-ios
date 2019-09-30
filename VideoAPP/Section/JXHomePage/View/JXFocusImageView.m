//
//  JXFocusImageView.m
//  alias_hemeiOS
//
//  Created by admxjx on 2018/1/30.
//  Copyright © 2018年 Hemefin. All rights reserved.
//

#import "JXFocusImageView.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "JXAdvModel.h"

@interface JXFocusImageView () <NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
@end

@implementation JXFocusImageView

-(void)reloadWithModel:(NSMutableArray<JXAdvModel *> *)dataAry
{
    self.dataAry = dataAry;
    [self reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        JXBannerListModel *model1= [JXBannerListModel new];
        //        model1.image_name = @"WechatIMG548";
        //        JXBannerListModel *model2= [JXBannerListModel new];
        //        model2.image_name = @"WechatIMG549";
        //        self.dataAry = @[model1,model2].mutableCopy;
        //        NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 72, Screen_Width, Screen_Width * 9 / 16)];
        self.delegate = self;
        self.dataSource = self;
        self.minimumPageAlpha = 0.1;
        self.isCarousel = YES;
        self.orientation = NewPagedFlowViewOrientationHorizontal;
        self.isOpenAutoScroll = YES;
        self.backgroundColor = [UIColor clearColor];
        [self reloadData];
        
        //        [self addSubview:pageFlowView];
    }
    return self;
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView
{
    return CGSizeMake(SCR_WIDTH, JXHeight(160));
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if ([self.JXDelegate respondsToSelector:@selector(JXFocusImageViewClick_img:)]) {
        [self.JXDelegate JXFocusImageViewClick_img:subIndex];
    }
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    //NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView
{
    return self.dataAry.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    bannerView.mainImageView.clipsToBounds = YES;
    
    // 阴影
//    bannerView.mainImageView.layer.cornerRadius = 4.f;
//    bannerView.layer.shadowColor = JXColor(0, 0, 0, 0.2).CGColor;
//    bannerView.layer.shadowOpacity = 0.8f;
//    bannerView.layer.shadowRadius = 5.f;
//    bannerView.layer.shadowOffset = CGSizeMake(2,2);
    
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    //    [bannerView.mainImageView jx_setImageWithUrl:self.dataAry[index].image ];
    //    http://img.soogif.com/E2CSa86sKKnvrjoO0RTIB81WW6Fqh9oO.gif
    [bannerView.mainImageView jx_setImageWithUrl:self.dataAry[index].imageURL];
    return bannerView;
}

@end
