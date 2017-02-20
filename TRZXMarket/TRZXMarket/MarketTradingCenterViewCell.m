//
//  MarketTradingCenterViewCell.m
//  TRZX
//
//  Created by N年後 on 2016/12/21.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "MarketTradingCenterViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MarketTradingCenterViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tradingCenterCoverImageView.layer.cornerRadius =   5;
    _tradingCenterCoverImageView.layer.masksToBounds = YES;

    _iconImageView.layer.cornerRadius =   5;
    _iconImageView.layer.masksToBounds = YES;
}


-(void)setRecomend:(NSDictionary *)recomend{

    if (_recomend!=recomend) {
        _recomend = recomend;

        [_tradingCenterCoverImageView setImageWithURL:[NSURL URLWithString:recomend[@"image"]]];
        [_iconImageView setImageWithURL:[NSURL URLWithString:recomend[@"logo"]]];
        _nameLabel.text = _recomend[@"name"];
    }
}



@end
