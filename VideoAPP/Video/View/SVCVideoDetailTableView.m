//
//  SVCVideoDetailTableView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCVideoDetailTableView.h"
#import "SVCVideoListCell.h"

@interface SVCVideoDetailTableView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation SVCVideoDetailTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"SVCVideoListCell" bundle:nil] forCellReuseIdentifier:@"SVCVideoListCell"];
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.JXDelegate respondsToSelector:@selector(SVCVideoDetailTableViewDidSelect:)]) {
        [self.JXDelegate SVCVideoDetailTableViewDidSelect:indexPath];
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
    SVCVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVCVideoListCell"];
    cell.modelInfo = self.dataAry[indexPath.row];
    cell.tagSelect = ^(NSInteger index) {
        if ([self.JXDelegate respondsToSelector:@selector(SVCVideoDetailTableViewDidSelect:)]) {
            [self.JXDelegate SVCVideoDetailTableViewDidSelect:indexPath Tag:index];
        }
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JXHeight(120);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, SCR_WIDTH, JXHeight(38));
    headView.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(JXWidth(12), 0, SCR_WIDTH, JXHeight(38));
    lab.font = FontSize(14);
    lab.text = self.dataAry.count ? @"猜你喜欢" : @"";
    [headView addSubview:lab];
    return headView;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return JXHeight(38);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)setDataAry:(NSMutableArray<JXVideoListModel *> *)dataAry
{
    _dataAry = dataAry;
    [self reloadData];
}


@end
