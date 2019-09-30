//
//  HMShowWebImgView.m
//  Hemefin_iOS
//
//  Created by admxjx on 2017/12/11.
//  Copyright © 2017年 Hemefin. All rights reserved.
//

#import "HMShowWebImgView.h"

@interface HMShowWebImgView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *bgView;

@property (strong,nonatomic) NSArray *mUrlArray;
@property (strong, nonatomic) NSString *title;
@property (strong,nonatomic) NSString *imageUrl;
@property (strong,nonatomic) UILabel *titleLab;

@end

@implementation HMShowWebImgView


- (void)showBigImage:(NSArray *)imageUrls atIndex:(NSInteger )index title:(NSString*)title{
    self.mUrlArray = imageUrls;
    self.title = title;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
    [self.bgView setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
    
    
    
    self.titleLab.text = [NSString stringWithFormat:@"%@(%ld/%lu)",title,(long)index+1,(unsigned long)imageUrls.count];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    //创建灰色透明背景，使其背后内容不可操作
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
    [self.scrollView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.f]];
    self.scrollView.delegate = self;
    // 是否分页
    self.scrollView.pagingEnabled = YES;
    //禁止垂直滚动
    //  self.scrollView.showsVerticalScrollIndicator = YES;
    //设置分页
    self.scrollView.pagingEnabled = YES;
    // 设置内容大小
    self.scrollView.contentSize = CGSizeMake(SCR_WIDTH*imageUrls.count,SCR_HIGHT);
    [self.bgView addSubview:self.scrollView];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCR_WIDTH, self.titleLab.height+25);
    view.backgroundColor = [UIColor colorWithHexString:@"000000" andAlpha:0.6];
    [self.bgView addSubview:view];
    [self.bgView bringSubviewToFront:view];
    
    //创建关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close_white"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(removeBigImage) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setFrame:CGRectMake(SCR_WIDTH-50, 25, 30, 30)];
    [closeBtn setCenterY:self.titleLab.centerY];
    [self.bgView addSubview:closeBtn];
    // 标题
    [self.bgView addSubview:self.titleLab];
    [self.bgView bringSubviewToFront:self.titleLab];
    for (int i= 0; i<imageUrls.count; i++) {
//        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
//        [doubleTap setNumberOfTapsRequired:2];
        
        UIScrollView *s = [[UIScrollView alloc]initWithFrame:CGRectMake(SCR_WIDTH*i,0,SCR_WIDTH, SCR_HIGHT)];
        s.bounces = NO;
        s.backgroundColor = [UIColor clearColor];
        s.contentSize =CGSizeMake(SCR_WIDTH,SCR_HIGHT);
        s.delegate = self;
        s.minimumZoomScale =1.0;
        s.maximumZoomScale =1.0;
        //        s.tag = i+1;
        [s setZoomScale:1.0];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCR_WIDTH, SCR_HIGHT)];
        //加载图片的时候  最好设置一个网络错误的预设图片
        [imageview sd_setImageWithURL:imageUrls[i] placeholderImage:[UIImage imageNamed:@"默认图"]];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.userInteractionEnabled =YES;
        imageview.tag = i+1;
//        [imageview addGestureRecognizer:doubleTap];
        [s addSubview:imageview];
        [self.scrollView addSubview:s];
    }
    self.scrollView.contentOffset = CGPointMake(SCR_WIDTH*index, 0);
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView ==self.scrollView){
        //        CGFloat x = scrollView.contentOffset.x;
        for (UIScrollView *s in scrollView.subviews){
            if ([s isKindOfClass:[UIScrollView class]]){
                [s setZoomScale:1.0]; //scrollView每滑动一次将要出现的图片较正常时候图片的倍数（将要出现的图片显示的倍数）
            }
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat doublePage = (scrollView.contentOffset.x) / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    intPage ++;  // 默认从第二页开始
    
//    self.pageControlTop.currentPage = intPage;
    self.titleLab.text = [NSString stringWithFormat:@"%@(%ld/%lu)",self.title,(long)intPage,(unsigned long)self.mUrlArray.count];
}

- (void)removeBigImage
{
    self.bgView.hidden = YES;
    [self removeFromSuperview];
}

-(void)dealloc
{
//    NSLog("HMShowWebImgView  delegate");
}

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = CGRectMake(20, 20, SCR_WIDTH-40, 50);
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}

@end
