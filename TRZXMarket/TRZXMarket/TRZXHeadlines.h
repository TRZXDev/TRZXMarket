//
//  TRZXHeadlines.h
//  TRZXMarket
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZXHeadlines : NSObject
@property (nonatomic, copy) NSString *mid;// 项目id
@property (nonatomic, copy) NSString *msgzPic;// 头条封面
@property (nonatomic, copy) NSString *date;// 日期
@property (nonatomic, copy) NSString *msgTitle; // 标题
@property (nonatomic, copy) NSString *msgDigest; // 内容
@property (nonatomic, copy) NSString *authName; // 交易中心名称


@end
