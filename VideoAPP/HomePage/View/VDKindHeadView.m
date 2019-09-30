//
//  VDKindHeadView.m
//  VideoAPP
//
//  Created by admxjx on 2019/5/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "VDKindHeadView.h"
#import "VDKindBtn.h"

@interface VDKindHeadView ()

@property (nonatomic, strong) UIScrollView *sortView;
@property (nonatomic, strong) UIScrollView *kindView;
@property (nonatomic, strong) UIScrollView *tagListView;
@property (nonatomic, strong) UIButton *sortBtn;
@property (nonatomic, strong) UIButton *kindBtn;
@property (nonatomic, strong) UIButton *tagListBtn;
@end

@implementation VDKindHeadView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpMainView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUpMainView
{
    CGRect sortRect = CGRectMake(0, JXHeight(15), SCR_WIDTH,JXHeight(36));
    CGRect kindRect = CGRectMake(0, JXHeight(15)+JXHeight(36), SCR_WIDTH,JXHeight(36));
    CGRect tagListRect = CGRectMake(0, JXHeight(15)+JXHeight(36)*2, SCR_WIDTH, JXHeight(36));
    self.sortView = [[UIScrollView alloc] initWithFrame: sortRect];
    self.sortView.bounces = NO;
    self.kindView = [[UIScrollView alloc] initWithFrame: kindRect];
    self.kindView.bounces = NO;
    self.tagListView = [[UIScrollView alloc] initWithFrame: tagListRect];
    self.tagListView.bounces = NO;
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(JXWidth(6), JXHeight(7), 50, JXHeight(22));
    lab.font = FontSize(12);
    lab.textColor = [UIColor hexStringToColor:@"8a8a8a"];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"分类";
    lab.backgroundColor = [UIColor hexStringToColor:@"efc289"];
    lab.layer.cornerRadius = 3;
    lab.clipsToBounds = YES;
    lab.width = [lab sizeThatFits:lab.size].width + 10;
    [self.kindView addSubview:lab];
    
    UILabel *sortlab = [[UILabel alloc] init];
    sortlab.frame = CGRectMake(JXWidth(6), JXHeight(7), 50, JXHeight(22));
    sortlab.font = FontSize(12);
    sortlab.textColor = [UIColor hexStringToColor:@"8a8a8a"];
    sortlab.textAlignment = NSTextAlignmentCenter;
    sortlab.text = @"类型";
    sortlab.backgroundColor = [UIColor hexStringToColor:@"efc289"];
    sortlab.layer.cornerRadius = 3;
    sortlab.clipsToBounds = YES;
    sortlab.width = [sortlab sizeThatFits:sortlab.size].width + 10;
    [self.sortView addSubview:sortlab];
    
    UILabel *taglab = [[UILabel alloc] init];
    taglab.frame = CGRectMake(JXWidth(6), JXHeight(7), 50, JXHeight(22));
    taglab.font = FontSize(12);
    taglab.textColor = [UIColor hexStringToColor:@"8a8a8a"];
    taglab.textAlignment = NSTextAlignmentCenter;
    taglab.text = @"标签";
    taglab.backgroundColor = [UIColor hexStringToColor:@"efc289"];
    taglab.layer.cornerRadius = 3;
    taglab.clipsToBounds = YES;
    taglab.width = [taglab sizeThatFits:taglab.size].width + 10;
    [self.tagListView addSubview:taglab];
    [self addSubview:self.sortView];
    [self addSubview:self.kindView];
    [self addSubview:self.tagListView];
}

-(void)setTagList:(NSMutableArray *)tagList
{
    _tagList = tagList;
    [self setUpTitleList:tagList view:self.tagListView];
}

-(void)setKindList:(NSMutableArray *)kindList
{
    _kindList = kindList;
    [self setUpTitleList:kindList view:self.kindView];
}

-(void)setSortList:(NSMutableArray *)sortList
{
    _sortList = sortList;
    [self setUpTitleList:sortList view:self.sortView];
}

-(void)setUpTitleList:(NSMutableArray*)ary view:(UIScrollView*)view
{
    __block float BtnX = JXWidth(63);
    float BtnH = JXHeight(22);
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = FontSize(12);
        [btn setTitle:[NSString stringWithFormat:@"%@",obj] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor hexStringToColor:@"818181"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click_btn:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(BtnX, JXHeight(7), 50, BtnH);
        btn.width = [btn sizeThatFits:btn.size].width + 10;
        if (self.sortView == view) {
            if ([self.sortString isEqualToString:[NSString stringWithFormat:@"%@",obj]]){
                [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateNormal];
                self.sortBtn = btn;
            }
            btn.tag = idx;
        }else if (self.kindView == view){
            btn.tag = idx+100;
            if ([self.kindString isEqualToString:[NSString stringWithFormat:@"%@",obj]]){
                [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateNormal];
                self.kindBtn = btn;
            }
        }else{
            btn.tag = idx+200;
            if ([self.tagString isEqualToString:[NSString stringWithFormat:@"%@",obj]]){
                [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateNormal];
                self.tagListBtn = btn;
            }
        }
        BtnX = btn.right + 5;
        [view addSubview:btn];
        view.contentSize = CGSizeMake(btn.right + 5, JXHeight(36));
    }];
}

-(void)click_btn:(UIButton*)btn
{
    if (btn.tag >= 200) {
        [self.tagListBtn setTitleColor:[UIColor hexStringToColor:@"818181"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateNormal];
        self.tagListBtn = btn;
        if (self.tagsblock) {
            self.tagsblock(btn.tag-200);
        }
    }else if (btn.tag >= 100){
        [self.kindBtn setTitleColor:[UIColor hexStringToColor:@"818181"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateNormal];
        self.kindBtn = btn;
        if (self.kindblock) {
            self.kindblock(btn.tag-100);
        }
    }else{
        [self.sortBtn setTitleColor:[UIColor hexStringToColor:@"818181"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexStringToColor:@"efc289"] forState:UIControlStateNormal];
        self.sortBtn = btn;
        if (self.sortblock) {
            self.sortblock(btn.tag);
        }
    }
}


@end
