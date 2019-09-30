//
//  SVCCollectionViewCell.m
//  SmartValleyCloudSeeding
//
//  Created by xumin on 2018/6/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCCollectionViewCell.h"
#import <SDCycleScrollView.h>
#import "TXScrollLabelView.h"
#import "WQLPaoMaView.h"
#import "SVCIndeModel.h"


@interface SVCCollectionViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic , weak)SDCycleScrollView *mainScrollerView;
@property (nonatomic , weak)TXScrollLabelView *scrollLabelView;
@property (nonatomic,weak) UIView *paomaView;

@end;

@implementation SVCCollectionViewCell
- (UIView *)paomaView
{
    if (!_paomaView) {
        UIView *viewAnima = [[UIView alloc] init];
        viewAnima.backgroundColor = [UIColor  blackColor];
        viewAnima.alpha = 0.30;
        WS(weakSelf);
        [self addSubview:viewAnima];
        [viewAnima mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.height.equalTo(@(30));
        }];
        _paomaView = viewAnima;
    }
    return _paomaView;
}
- (SDCycleScrollView *)mainScrollerView
{
    if (!_mainScrollerView) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] init];
        view.delegate = self;
        view.frame = self.contentView.frame;
        [self.contentView addSubview:view];
        _mainScrollerView = view;
    }
    return _mainScrollerView;
}
-(TXScrollLabelView *)scrollLabelView{
    if (!_scrollLabelView) {
        TXScrollLabelView *TXView = [TXScrollLabelView scrollWithTitle:@"" type:TXScrollLabelViewTypeLeftRight velocity:1.5 options:UIViewAnimationOptionCurveEaseInOut];;
        TXView.tx_centerX  = (kScreenWidth - 30) * 0.5;
        TXView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        TXView.scrollSpace = 10;
        TXView.font = [UIFont systemFontOfSize:14];
        TXView.textAlignment = NSTextAlignmentCenter;
        TXView.scrollTitleColor = [UIColor whiteColor];
        TXView.layer.cornerRadius = 5;
        TXView.frame = CGRectMake(30, 0, kScreenWidth - 30, 30);
        [self addTopview];
        [self.paomaView addSubview:TXView];
        _scrollLabelView = TXView;
    }
    return _scrollLabelView;
}
- (void)addTopview
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
    imageView.image = [UIImage imageNamed:@"icon_gonggao"];
    [self.paomaView addSubview:imageView];
}
-(void)awakeFromNib{
    [super awakeFromNib];
   
}
-(void)setNotice:(NSString *)notice{
    _notice = notice;
    self.scrollLabelView.scrollTitle = notice;
    
    [self.scrollLabelView beginScrolling];
}


-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    self.mainScrollerView.imageURLStringsGroup = self.imageArr;
    self.mainScrollerView.placeholderImage = [UIImage imageNamed:@"banner"];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.adListClick) {
        self.adListClick(index);
    }
    NSLog(@"我点击的是哪一个啊 %ld",index);
}


@end
