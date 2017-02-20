//
//  MarketEntranceIconsView.h
//  Wuxianda
//
//  Created by MichaelPPP on 16/7/12.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//  入口图标View

#import <UIKit/UIKit.h>

typedef void(^MarketTradingCenterViewBlock)(NSDictionary *recomend);

@interface MarketTradingCenterView : UIView

@property (weak, nonatomic) IBOutlet UIView *headlineContentView;
@property (weak, nonatomic) IBOutlet UIView *headlineBgContentView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

-(void)reloadData:(NSArray *)recomends;

+ (instancetype)marketTradingCenterViewWithBlock:(MarketTradingCenterViewBlock)block;

@end

















































