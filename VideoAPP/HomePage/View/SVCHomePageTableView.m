//
//  SVCHomePageTableView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/6.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageTableView.h"
#import "SVCHomePageImgCell.h"
#import "SVCHomePageModel.h"
#import "SVCVideoTableViewCell.h"


@interface SVCHomePageTableView ()<UITableViewDelegate,UITableViewDataSource,SVCHomePageLiveViewDelegate>

@property (nonatomic, strong) NSArray<SVCHomePageModel*> *dataAry;


@end

@implementation SVCHomePageTableView

-(void)reloadDataWithArray:(NSArray<SVCHomePageModel*> *)array{
    self.dataAry = array;
    [self reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        //        self.estimatedRowHeight = 0;
        //        self.estimatedSectionHeaderHeight = 0;
        //        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    self.didSelectContentOffsetY = self.contentOffset;
    if ([self.JXDelegate respondsToSelector:@selector(SVCHomePageTableViewDidSelect:)]) {
        [self.JXDelegate SVCHomePageTableViewDidSelect:indexPath];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataAry[indexPath.row].type isEqualToString:@"1"]) { // 无图
        SVCHomePageImgOfTypeNoImgCell *cell = (SVCHomePageImgOfTypeNoImgCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SVCHomePageImgCell" owner:nil options:nil] firstObject];
            [cell updateHomePageWithMode:self.dataAry[indexPath.row]];
        }
        return cell;
    } else if ([self.dataAry[indexPath.row].type isEqualToString:@"2"] ||
              [self.dataAry[indexPath.row].type isEqualToString:@"4"]){ // 1图
        SVCHomePageImgOfTypeOneImgCell *cell = (SVCHomePageImgOfTypeOneImgCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SVCHomePageImgCell" owner:nil options:nil] [1];
            ;
            [cell updateHomePageWithMode:self.dataAry[indexPath.row]];
        }
        return cell;
    } else if ([self.dataAry[indexPath.row].type isEqualToString:@"3"] ||
              [self.dataAry[indexPath.row].type isEqualToString:@"5"]){ // 3图
        SVCHomePageImgCell *cell = (SVCHomePageImgCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SVCHomePageImgCell" owner:nil options:nil] lastObject];
            ;
            [cell updateHomePageWithMode:self.dataAry[indexPath.row]];
        }
        return cell;
    } else{ // 视频
        SVCVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SVCVideoTableViewCell" owner:nil options:nil] lastObject];
            [cell setUpHomePageModel:self.dataAry[indexPath.row]];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataAry[indexPath.row].type isEqualToString:@"1"]) { // 无图
        return JXHeight(55);
    }else if ([self.dataAry[indexPath.row].type isEqualToString:@"2"] ||
              [self.dataAry[indexPath.row].type isEqualToString:@"4"]){ // 1图
        return JXHeight(102);
    }else if ([self.dataAry[indexPath.row].type isEqualToString:@"3"] ||
              [self.dataAry[indexPath.row].type isEqualToString:@"5"]){ // 3图
        return JXHeight(138);
    }else{ // 视频
        SVCVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SVCVideoTableViewCell" owner:nil options:nil] lastObject];
        }
        return [cell setUpHomePageModel:self.dataAry[indexPath.row]];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.hiddenLiveView) {
        return [UIView new];
    }
    return self.liveView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.hiddenLiveView) {
        return 0.1;
    }
    return JXHeight(210)-1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)live_more{
    if ([self.JXDelegate respondsToSelector:@selector(SVCHomePageLiveDidSelect:)]) {
        [self.JXDelegate SVCHomePageLiveDidSelect:9999];
    }
}

-(SVCHomePageLiveView *)liveView
{
    if (!_liveView) {
        _liveView = [[NSBundle mainBundle] loadNibNamed:@"SVCHomePageLiveView" owner:nil options:nil].lastObject;
        _liveView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        _liveView.JXDelegate = self;
        [_liveView.moreBtn addTarget:self action:@selector(live_more) forControlEvents:UIControlEventTouchUpInside];
    }
    return _liveView;
}

-(void)SVCHomePageLiveViewDidSelect:(NSInteger)index
{
    if ([self.JXDelegate respondsToSelector:@selector(SVCHomePageLiveDidSelect:)]) {
        [self.JXDelegate SVCHomePageLiveDidSelect:index];
    }
}

-(void)setHiddenLiveView:(BOOL)hiddenLiveView
{
    _hiddenLiveView = hiddenLiveView;
    [self reloadData];
}


@end
