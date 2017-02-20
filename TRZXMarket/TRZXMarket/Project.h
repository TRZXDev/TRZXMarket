//
//  Project.h
//  TRZX
//
//  Created by N年後 on 2016/11/12.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property (nonatomic, copy) NSString *mid;// 项目id
@property (nonatomic, copy) NSString *projectImg;// 项目封面
@property (nonatomic, copy) NSString *name;// 项目名称
@property (nonatomic, copy) NSString *areaName; // 融资阶段
@property (nonatomic, copy) NSString *tradeInfo; // 所属行业
@property (nonatomic, copy) NSString *companyName; // 公司名称
@property (nonatomic, copy) NSString *projectLevel; //
@property (nonatomic, copy) NSString *briefIntroduction; //


@end
