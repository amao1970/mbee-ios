//
//  SVCVideoListCell.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCVideoListCell.h"

@implementation SVCVideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModelInfo:(JXVideoListModel *)modelInfo
{
    _modelInfo = modelInfo;
    self.titleLab.text = modelInfo.title;
    if (!self.subtitleLab.text.length) {
        NSInteger lookNum = arc4random() % 190;
        lookNum+=10;
        self.subtitleLab.text = [NSString stringWithFormat:@"%ld万次播放",lookNum];
    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:modelInfo.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
    self.attLab.text = modelInfo.attribute;
    self.attLab.hidden = !modelInfo.attribute.length;
    self.attLab.width = [self.attLab sizeThatFits:self.attLab.size].width+13;
    self.attLab.x = self.img.right - 8 - self.attLab.width;
    
    if (self.tagView.subviews.count>0) return;
    self.tagView.padding = UIEdgeInsetsMake( 4, 0, 10, 10);
    self.tagView.interitemSpacing = 10;
    self.tagView.lineSpacing = 10;
    self.tagView.clipsToBounds = YES;
    SVCWeakSelf;
    self.tagView.didTapTagAtIndex = ^(NSUInteger index){
        // 点击事件
        NSLog(@"点击事件%ld",index);
        if (weakSelf.tagSelect) {
            weakSelf.tagSelect(index);
        }
    };
    
//    self.tagView.translatesAutoresizingMaskIntoConstraints = NO;
    [modelInfo.tag enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKTag *tag = [SKTag tagWithText: obj];
        tag.textColor = [UIColor hexStringToColor:@"dec6a2"];
        tag.bgColor = [UIColor hexStringToColor:@"fdedda"];
        tag.font = [UIFont systemFontOfSize:12];
        tag.padding = UIEdgeInsetsMake(2, 4, 2, 4);
        tag.cornerRadius = 2;
        [self.tagView addTag:tag];
    }];
    
    [self addSubview:self.tagView];
    
    [self setNeedsLayout];
    [self layoutSubviews];
    [self.tagView layoutSubviews];
    self.tagView.height = JXHeight(55);
    self.tagView.x = JXWidth(280);
    self.tagView.y = JXHeight(34);
    self.tagView.frame = CGRectMake(JXWidth(180), JXHeight(34), self.tagView.width, self.tagView.height);
    [self.tagView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.attLab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.attLab.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.attLab.layer.mask = cornerRadiusLayer;
}



-(void)click
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.tagView.x = JXWidth(280);
//    self.tagView.y = JXHeight(34);
//    self.tagView.frame = CGRectMake(JXWidth(180), JXHeight(34), self.tagView.width, self.tagView.height);
//    [self setNeedsLayout];
//    [self.contentView setNeedsLayout];
}

@end
