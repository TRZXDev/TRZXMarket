//
//  xiaoxi2Cell.m
//  tourongzhuanjia
//
//  Created by 移动微世界 on 15/12/18.
//  Copyright © 2015年 JWZhang. All rights reserved.
//

#import "TRZXHeadlinesCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TRZXHeadlinesCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView.layer.cornerRadius =   5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHeadlines:(TRZXHeadlines *)headlines{

    [self.topImage setImageWithURL:[NSURL URLWithString:headlines.msgzPic]];
    self.timeLabel.text = headlines.date;
    self.whoLabel.text = headlines.authName;
    self.biaotiLabel.text = headlines.msgTitle;
    self.jianjieLabel.text = headlines.msgDigest;
    


}

@end
