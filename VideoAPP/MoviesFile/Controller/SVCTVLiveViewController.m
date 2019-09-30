//
//  SVCTVLiveViewController.m
//  SmartValleyCloudSeeding
//
//  Created by 华安 on 2018/7/10.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTVLiveViewController.h"
#import "SVCTVLiveLeftCell.h"
#import "SVCTVLiveRightCell.h"

#define leftTableWidth 120

@interface SVCTVLiveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *leftTabelView; /**<<#属性#> */
@property(nonatomic, strong) UITableView *rightTabelView; /**<<#属性#> */
@property(nonatomic, strong) NSMutableArray *leftTableViewList; /**<<#属性#> */
@property(nonatomic, strong) NSMutableArray *rightTableViewList; /**<<#属性#> */
@end

@implementation SVCTVLiveViewController

- (NSMutableArray *)leftTableViewList{
    
    if (!_leftTableViewList) {
        _leftTableViewList = [NSMutableArray arrayWithCapacity:1];
    }
    return _leftTableViewList;
}
- (NSMutableArray *)rightTableViewList{
    if (!_rightTableViewList) {
        _rightTableViewList = [NSMutableArray arrayWithCapacity:1];
    }
    return _rightTableViewList;
}

- (UITableView *)leftTabelView{
    if (!_leftTabelView) {
        _leftTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,GetWidthByScreenWidth(leftTableWidth), self.view.height) style:UITableViewStylePlain];
        _leftTabelView.delegate = self;
        _leftTabelView.dataSource = self;
        _leftTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftTabelView;
}
- (UITableView *)rightTabelView{
    if (!_rightTabelView) {
        _rightTabelView = [[UITableView alloc] initWithFrame:CGRectMake(GetWidthByScreenWidth(leftTableWidth), 0,SCREEN_WIDTH - GetWidthByScreenWidth(leftTableWidth) - 0.5, self.view.height) style:UITableViewStylePlain];
        _rightTabelView.delegate = self;
        _rightTabelView.dataSource = self;
        _rightTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _rightTabelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftTabelView];
    [self.view addSubview:self.rightTabelView];
    [self setupMarginView];
}
- (void)setupMarginView{
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(GetWidthByScreenWidth(leftTableWidth), 0, 0.5, SCREEN_HEIGHT)];
    marginView.backgroundColor = SVCColorFromRGB(0xf0f0f0);
    [self.view addSubview:marginView];
}


-(void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTabelView) {
        SVCTVLiveLeftCell *leftCell = [SVCTVLiveLeftCell cellWithTableView:tableView];
        return leftCell;
    }else{
        SVCTVLiveRightCell *rightCell = [SVCTVLiveRightCell cellWithTableView:tableView];
        return rightCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTabelView) {
        
        [self.rightTabelView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTabelView) {
        return GetHeightByScreenHeigh(50);
    }else{
        return GetHeightByScreenHeigh(44);
    }
}


@end
