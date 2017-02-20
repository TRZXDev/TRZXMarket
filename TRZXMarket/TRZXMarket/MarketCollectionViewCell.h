//
//  MarketCollectionViewCell.h
//  Wuxianda
//
//  Created by MichaelPPP on 16/7/12.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//  入口图标collectionView Cell

#import <UIKit/UIKit.h>
static NSString *kCellIdentifier_MarketCollectionViewCell = @"MarketCollectionViewCell";

@interface MarketCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end
