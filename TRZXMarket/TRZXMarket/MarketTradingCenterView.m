//
//  MarketEntranceIconsView.m
//  Wuxianda
//
//  Created by MichaelPPP on 16/7/12.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//

#import "MarketTradingCenterView.h"
#import "MarketTradingCenterViewCell.h"
#import "TRZXKit.h"
@interface MarketTradingCenterView () <UICollectionViewDataSource,UICollectionViewDelegate>

/** 入口图标视图 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) MarketTradingCenterViewBlock block;
@property (nonatomic, strong) NSArray *recomends;

@end

@implementation MarketTradingCenterView



#pragma mark - Public
+ (instancetype)marketTradingCenterViewWithBlock:(MarketTradingCenterViewBlock)block
{
    MarketTradingCenterView *view = [MarketTradingCenterView viewFromXib];
    view.block = block;
    return view;
}

#pragma mark - Override

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // self
    self.autoresizingMask = UIViewAutoresizingNone;

    _collectionView.scrollsToTop = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    CGFloat itemW = 160;
    CGFloat itemH = 90;
    layout.sectionInset = UIEdgeInsetsMake(12,12,12,12);
    layout.itemSize = CGSizeMake(itemW, itemH);
//    layout.minimumLineSpacing = 12;
//    layout.minimumInteritemSpacing = 12;
    _collectionView.collectionViewLayout = layout;
    
    // register cell

//    [_collectionView registerClass:[MarketCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_MarketCollectionViewCell];

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketTradingCenterViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCellIdentifier_MarketTradingCenterViewCell];
}

-(void)reloadData:(NSArray *)recomends{
    if (_recomends!= recomends) {
        _recomends = recomends;
        [_collectionView reloadData];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _recomends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MarketTradingCenterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_MarketTradingCenterViewCell forIndexPath:indexPath];

    NSDictionary *recomend = _recomends[indexPath.row];
    cell.recomend = recomend;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *recomend = _recomends[indexPath.row];
    if (self.block) {
        self.block(recomend);
    }

}


@end









































