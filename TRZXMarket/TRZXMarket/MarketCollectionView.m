//
//  MarketEntranceIconsView.m
//  Wuxianda
//
//  Created by MichaelPPP on 16/7/12.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//

#import "MarketCollectionView.h"
#import "MarketCollectionViewCell.h"
#import "TRZXKit.h"
@interface MarketCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>

/** 入口图标视图 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) MarketCollectionViewCellBlock block;
@end

@implementation MarketCollectionView



#pragma mark - Public
+ (instancetype)marketCollectionViewCellWithBlock:(MarketCollectionViewCellBlock)block
{
    MarketCollectionView *view = [MarketCollectionView viewFromXib];
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

    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (self.width-0) / 4;
    CGFloat itemH = 74;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView.collectionViewLayout = layout;
    
    // register cell

//    [_collectionView registerClass:[MarketCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_MarketCollectionViewCell];

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCellIdentifier_MarketCollectionViewCell];
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_MarketCollectionViewCell forIndexPath:indexPath];

    if (indexPath.row==0) {

        cell.titleLabel.text = @"融资项目";
        cell.iconImageView.image = [UIImage imageNamed:@"融资项目"];

    }else if (indexPath.row==1){

        cell.titleLabel.text = @"路演直播";
        cell.iconImageView.image = [UIImage imageNamed:@"路演直播"];

    }else if (indexPath.row==2){

        cell.titleLabel.text = @"机构投资人";
        cell.iconImageView.image = [UIImage imageNamed:@"机构投资人"];

    }else if (indexPath.row==3){

        cell.titleLabel.text = @"附近股东";
        cell.iconImageView.image = [UIImage imageNamed:@"附近股东"];

    }

    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.block) {
        self.block(indexPath.row);
    }

}


@end









































