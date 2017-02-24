//
//  xiaoxi2Cell.h
//  tourongzhuanjia
//
//  Created by 移动微世界 on 15/12/18.
//  Copyright © 2015年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRZXHeadlines.h"

static NSString *kCellIdentifier_TRZXHeadlinesCell = @"TRZXHeadlinesCell";

@interface TRZXHeadlinesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jianjieLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoLabel;
@property (strong, nonatomic) TRZXHeadlines *headlines;


@end
