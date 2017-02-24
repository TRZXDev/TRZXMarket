//
//  TRZXHeadlinesViewModel.m
//  TRZXMarket
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXHeadlinesViewModel.h"
#import "MJExtension.h"

@implementation TRZXHeadlinesViewModel
+(NSDictionary *)objectClassInArray{
    return @{@"data":[TRZXHeadlines class]};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _canLoadMore = NO;
        _isLoading = _willLoadMore = NO;
        _pageNo = [NSNumber numberWithInteger:1];
        _pageSize = [NSNumber numberWithInteger:15];
    }
    return self;
}


-(NSDictionary *)toTipsParams{

    NSDictionary *params = @{@"requestType":@"Messagez_List",
                             @"apiType":@"findPageList",
                             @"msgType":@"2",
                             @"msgPlace":@"7",
                             @"pageNo" : _willLoadMore? [NSNumber numberWithInteger:_pageNo.integerValue +1]: [NSNumber numberWithInteger:1],
                             @"pageSize" : _pageSize};
    return params;
}


// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_findPageList {

    if (!_requestSignal_findPageList) {

        _requestSignal_findPageList = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:self.toTipsParams method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {
                    TRZXHeadlinesViewModel *model = [TRZXHeadlinesViewModel mj_objectWithKeyValues:response];
                    [self configWithObj:model];
                    [subscriber sendNext:self];
                    [subscriber sendCompleted];

                }else{
                    [subscriber sendError:error];
                }
            }];

            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{

                [TRZXNetwork cancelRequestWithURL:@""];
            }];
        }];
    }
    return _requestSignal_findPageList;
}


- (void)configWithObj:(TRZXHeadlinesViewModel *)model{

    self.pageNo = model.pageNo;
    self.pageSize = model.pageSize;
    self.totalPage = model.totalPage;

    if (_willLoadMore) {
        [self.data addObjectsFromArray:model.data];
    }else{
        self.data = [NSMutableArray arrayWithArray:model.data];
    }
    _canLoadMore = _pageNo.intValue < _totalPage.intValue&&_totalPage.intValue>1;
    
}
@end
