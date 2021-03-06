//
//  MarketViewCell.h
//  TRZX
//
//  Created by N年後 on 2016/12/20.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

static NSString *kCellIdentifier_MarketViewCell = @"MarketViewCell";

@interface MarketViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *projectCoversImageView;
@property (strong, nonatomic) Project *project;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
