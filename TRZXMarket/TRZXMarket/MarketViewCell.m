//
//  MarketViewCell.m
//  TRZX
//
//  Created by N年後 on 2016/12/20.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//



#import "MarketViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MarketViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setProject:(Project *)project{
    if (_project!=project) {
        _project = project;

        [_projectCoversImageView setImageWithURL:[NSURL URLWithString:project.projectImg]];
        _nameLabel.text = project.name;
        _tradeInfoLabel.text = [NSString stringWithFormat:@"%@/%@",project.tradeInfo,project.areaName] ;
//        _sourceLabel.text = [NSString stringWithFormat:@"项目来源:%@",project.companyName];
        _contentLabel.text = [NSString stringWithFormat:@"%@",project.briefIntroduction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
