//
//  TRZXHeadlinesViewModel.h
//  TRZXMarket
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRZXHeadlines.h"
#import "ReactiveCocoa.h"
#import "TRZXNetwork.h"
@interface TRZXHeadlinesViewModel : NSObject
@property (readwrite, nonatomic, strong) NSNumber *pageNo, *pageSize, *totalPage;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;

@property (strong, nonatomic) RACSignal *requestSignal_findPageList; ///< 网络请求信号量

@property (readwrite, nonatomic, strong) NSMutableArray *data; //四版头条


-(NSDictionary *)toTipsParams;
- (void)configWithObj:(TRZXHeadlinesViewModel *)model;
@end
