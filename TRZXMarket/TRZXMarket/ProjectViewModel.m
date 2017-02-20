//
//  TRMarketModel.m
//  TRZX
//
//  Created by N年後 on 16/8/28.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "ProjectViewModel.h"
#import "MJExtension.h"

@implementation ProjectViewModel
+(NSDictionary *)objectClassInArray{
    return @{@"data":[Project class]};
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

    NSDictionary *params = @{@"requestType" :@"Market_Api",
                             @"apiType" :@"list",
                             @"pageNo" : _willLoadMore? [NSNumber numberWithInteger:_pageNo.integerValue +1]: [NSNumber numberWithInteger:1],
                             @"pageSize" : _pageSize};
    return params;
}





// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_list {

    if (!_requestSignal_list) {

        _requestSignal_list = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:self.toTipsParams method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {
                    self.listArray = [Project mj_objectArrayWithKeyValuesArray:response[@"data"]];
                    [subscriber sendNext:self.listArray];
                    [subscriber sendCompleted];

                }else{
                    [subscriber sendError:error];
                }
            }];

            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{

                [TRZXNetwork cancelRequestWithURL:nil];
            }];
        }];
    }
    return _requestSignal_list;
}



// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_home {

    if (!_requestSignal_home) {

        NSDictionary *params = @{@"requestType":@"Market_Api",
                                 @"apiType":@"home"};

        _requestSignal_home = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:params method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {
                    self.topArray = [NSArray arrayWithArray:response[@"top"]];

                    NSMutableArray *images = [[NSMutableArray alloc]init];
                    for (NSDictionary *dic in self.topArray) {
                        [images addObject:dic[@"newCarouselImg"]];
                    }
                    self.topImagesArray = [NSArray arrayWithArray:images];
                    self.recomendArray = [NSArray arrayWithArray:response[@"recomend"]] ;
                    [subscriber sendNext:self];
                    [subscriber sendCompleted];

                }else{
                    [subscriber sendError:error];
                }
            }];

            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{

                [TRZXNetwork cancelRequestWithURL:nil];
            }];
        }];
    }
    return _requestSignal_home;
}


// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_findPageList {

    if (!_requestSignal_findPageList) {

        NSDictionary *params = @{@"requestType":@"Messagez_List",
                                 @"apiType":@"findPageList",
                                 @"msgType":@"2",
                                 @"msgPlace":@"7",
                                 @"pageNo":@"1"};

        _requestSignal_findPageList = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:params method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {
                    self.headlines = [NSArray arrayWithArray:response[@"data"]];
                    [subscriber sendNext:self];
                    [subscriber sendCompleted];

                }else{
                    [subscriber sendError:error];
                }
            }];

            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{

                [TRZXNetwork cancelRequestWithURL:nil];
            }];
        }];
    }
    return _requestSignal_findPageList;
}





- (void)configWithObj:(ProjectViewModel *)model{

    self.pageNo = model.pageNo;
    self.pageSize = model.pageSize;
    self.totalPage = model.totalPage;

    if (_willLoadMore) {
        [self.listArray addObjectsFromArray:model.listArray];
    }else{
        self.listArray = [NSMutableArray arrayWithArray:model.listArray];
    }
    _canLoadMore = _pageNo.intValue < _totalPage.intValue&&_totalPage.intValue>1;

}


@end





