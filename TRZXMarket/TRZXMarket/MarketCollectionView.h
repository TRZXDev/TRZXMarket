//
//  MarketEntranceIconsView.h
//  Wuxianda
//
//  Created by MichaelPPP on 16/7/12.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//  入口图标View

#import <UIKit/UIKit.h>

/**
 *  投融市场Cell入口
 */
typedef NS_ENUM(NSInteger, MarketCollectionViewCellType) {
    /**
     *  融资项目
     */
    MarketCollectionViewCellTypeFinancingProject = 0,
    /**
     *  路演直播
     */
    MarketCollectionViewCellTypeRoadshowLive = 1,
    /**
     *  投资人
     */
    MarketCollectionViewCellTypeInvestors = 2,
    /**
     *  附近股东
     */
    MarketCollectionViewCellTypeNearShareholders = 3,

};

typedef void(^MarketCollectionViewCellBlock)(MarketCollectionViewCellType type);

@interface MarketCollectionView : UIView


+ (instancetype)marketCollectionViewCellWithBlock:(MarketCollectionViewCellBlock)block;

@end

















































