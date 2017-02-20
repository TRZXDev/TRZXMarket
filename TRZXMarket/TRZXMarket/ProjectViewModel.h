//
//  TRMarketModel.h
//  TRZX
//
//  Created by N年後 on 16/8/28.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "ReactiveCocoa.h"
#import "TRZXNetwork.h"
@interface ProjectViewModel : NSObject

@property (readwrite, nonatomic, strong) NSNumber *pageNo, *pageSize, *totalPage;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;

@property (strong, nonatomic) RACSignal *requestSignal_list; ///< 网络请求信号量
@property (strong, nonatomic) RACSignal *requestSignal_home; ///< 首页
@property (strong, nonatomic) RACSignal *requestSignal_findPageList; ///< 四版头条

@property (readwrite, nonatomic, strong) NSMutableArray *listArray; // 市场项目列表
@property (readwrite, nonatomic, strong) NSArray *topArray;// 市场轮播
@property (readwrite, nonatomic, strong) NSArray *topImagesArray;// 市场轮播图片数组
@property (readwrite, nonatomic, strong) NSArray *recomendArray;// 交易中心列表
@property (readwrite, nonatomic, strong) NSArray *headlines;// 四版头条


-(NSDictionary *)toTipsParams;
- (void)configWithObj:(ProjectViewModel *)model;
@end




