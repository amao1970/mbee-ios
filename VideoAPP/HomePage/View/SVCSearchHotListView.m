//
//  SVCSearchHotListView.m
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SVCSearchHotListView.h"
#import "JXSearchHotListCell.h"

@interface SVCSearchHotListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation SVCSearchHotListView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"JXSearchHotListCell" bundle:nil] forCellWithReuseIdentifier:@"JXSearchHotListCell"];
    }
    return self;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectBlack) {
        self.didSelectBlack(indexPath.row);
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JXSearchHotListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXSearchHotListCell" forIndexPath:indexPath];
    cell.titleLab.text = self.dataAry[indexPath.row].name;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JXWidth(187), JXHeight(45));
}

-(void)setDataAry:(NSMutableArray<SVCSearchHotListModel*> *)dataAry
{
    _dataAry = dataAry;
    [self reloadData];
}

@end
