//
//  MarketTradingCenterViewCell.h
//  TRZX
//
//  Created by N年後 on 2016/12/21.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *kCellIdentifier_MarketTradingCenterViewCell = @"MarketTradingCenterViewCell";

@interface MarketTradingCenterViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tradingCenterCoverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSDictionary *recomend;

@end
