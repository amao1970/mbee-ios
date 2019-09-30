//
//  SVCHomePageLiveView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2018/12/7.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SVCHomePageLiveView.h"
#import "SVCHomePageLiveMoreCell.h"
#import "SVCHomePageLiveCell.h"

@interface SVCHomePageLiveView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SVCHomePageLiveView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self updateUI];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
//    self.collectionView.alwaysBounceHorizontal = YES;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    layout.minimumInteritemSpacing = 5 ;
    layout.minimumLineSpacing = 5 ;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SVCHomePageLiveCell" bundle:nil] forCellWithReuseIdentifier:@"SVCHomePageLiveCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SVCHomePageLiveMoreCell" bundle:nil] forCellWithReuseIdentifier:@"SVCHomePageLiveMoreCell"];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.JXDelegate respondsToSelector:@selector(SVCHomePageLiveViewDidSelect:)]) {
        [self.JXDelegate SVCHomePageLiveViewDidSelect:indexPath.row];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataAry.count < 4) {
        return self.dataAry.count+1;
    }
    return 4;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3 ||
        (self.dataAry.count < 3 && indexPath.row == self.dataAry.count - 2) ||
        self.dataAry.count == 0) {
        SVCHomePageLiveMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCHomePageLiveMoreCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SVCHomePageLiveMoreCell" owner:nil options:nil].lastObject;
        }
        return cell;
    }
    
    SVCHomePageLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SVCHomePageLiveCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SVCHomePageLiveCell" owner:nil options:nil].lastObject;
        cell.backgroundColor = [UIColor whiteColor];
    }
    [cell updateLiveWithModel:self.dataAry[indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JXWidth(117), JXHeight(150));
}

-(void)setDataAry:(NSMutableArray<SVCLiveModel*> *)dataAry
{
    _dataAry = dataAry;
    [self.collectionView reloadData];
}

@end
