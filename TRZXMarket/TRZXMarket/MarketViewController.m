//
//  LvYanViewController.m
//  tourongzhuanjia
//
//  Created by sweet luo on 15/10/14.
//  Copyright © 2015年 KristyFuWa. All rights reserved.
//

#import "MarketViewController.h"
#import "TRZXMarketTabSectionHeaderView.h"
#import "MarketViewCell.h"
#import "TRZXShufflingView.h"
#import "MarketCollectionView.h"
#import "MarketTradingCenterView.h"
#import "MarketNavHeadView.h"
#import "TRZXKit.h"
#import "ProjectViewModel.h"
#import "ZHScrollViewLB.h"
@interface MarketViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *marketHeaderView;
@property (nonatomic, strong) MarketNavHeadView *marketNavHeadView;
@property (nonatomic, strong) TRZXShufflingView *shufflingView;
@property (nonatomic, strong) MarketCollectionView *marketCollectionView;
@property (nonatomic, strong) MarketTradingCenterView *marketTradingCenterView;
@property (nonatomic, strong) UITableView *marketTableView;
@property (strong, nonatomic) ZHScrollViewLB *zhScrollViewLB;



@property (strong, nonatomic) ProjectViewModel *projectViewModel;

@end

@implementation MarketViewController






- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.marketTableView];

    [self requestSignal_home];
    [self requestSignal_list];
    [self requestSignal_findPageList];

}

// 发起请求
- (void)requestSignal_home {


    [self.projectViewModel.requestSignal_home subscribeNext:^(id x) {

        // 请求完成后，更新UI
        [self.shufflingView images:self.projectViewModel.topImagesArray];

        [self.marketTradingCenterView reloadData:self.projectViewModel.recomendArray];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}

// 发起请求
- (void)requestSignal_findPageList {


    [self.projectViewModel.requestSignal_findPageList subscribeNext:^(id x) {

        NSMutableArray *imageModels = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in self.projectViewModel.headlines) {
            [imageModels addObject:dic[@"msgTitle"]];
        }
        [self setZHScrollViewLB:[NSArray arrayWithArray:imageModels]];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}




// 发起请求
- (void)requestSignal_list {


    [self.projectViewModel.requestSignal_list subscribeNext:^(id x) {

        // 请求完成后，更新UI

        [self.marketTableView reloadData];


    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _projectViewModel.listArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TRZXMarketTabSectionHeaderView *view=[[[NSBundle mainBundle] loadNibNamed:kCellIdentifier_TRZXMarketTabSectionHeaderView owner:self options:nil] lastObject];
    view.titleLabel.text = @"推荐课程";
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MarketViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MarketViewCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier_MarketViewCell owner:self options:nil] lastObject];
    }
    
    Project *project = [_projectViewModel.listArray objectAtIndex:indexPath.row];
    cell.project = project;
    
    if (indexPath.row==_projectViewModel.listArray.count-1) {
        cell.bottomView.hidden = YES;
    }else{
        cell.bottomView.hidden = NO;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
}





-(MarketNavHeadView *)marketNavHeadView{
    if (!_marketNavHeadView) {
        // 内容视图
        _marketNavHeadView = [MarketNavHeadView viewFromXib];
        _marketNavHeadView.frame = CGRectMake(0, 0, self.view.width, 64);
        _marketNavHeadView.backgroundColor = [UIColor clearColor];
    }
    return _marketNavHeadView;
}


#pragma mark - properties


-(UITableView *)marketTableView{
    if (!_marketTableView) {
        // 内容视图
        _marketTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _marketTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _marketTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _marketTableView.dataSource = self;
        _marketTableView.delegate = self;
        _marketTableView.tableHeaderView = self.marketHeaderView;
        _marketTableView.estimatedRowHeight = 316;  //  随便设个不那么离谱的值
        _marketTableView.rowHeight = UITableViewAutomaticDimension;

    }
    return _marketTableView;
}



-(UIView *)marketHeaderView{
    if (!_marketHeaderView) {
        _marketHeaderView = [[UIView alloc]init];
        [_marketHeaderView addSubview:self.shufflingView];
        [_marketHeaderView addSubview:self.marketCollectionView];
        [_marketHeaderView addSubview:self.marketTradingCenterView];
        _marketHeaderView.frame = CGRectMake(0, 0, self.view.width, self.marketTradingCenterView.bottom);
    }
    return _marketHeaderView;
}



-(TRZXShufflingView *)shufflingView{
    if (!_shufflingView) {
        _shufflingView = [[TRZXShufflingView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width*9/16)];
    }
    return _shufflingView;
}


-(MarketCollectionView *)marketCollectionView{
    if (!_marketCollectionView) {

        // 底部入口View
        _marketCollectionView = [MarketCollectionView marketCollectionViewCellWithBlock:^(MarketCollectionViewCellType type) {


        }];

        _marketCollectionView.frame = CGRectMake(0, _shufflingView.bottom, self.view.width, 74);

    }
    return _marketCollectionView;
}

-(MarketTradingCenterView *)marketTradingCenterView{
    if (!_marketTradingCenterView) {
        // 交易中心
        _marketTradingCenterView = [MarketTradingCenterView marketTradingCenterViewWithBlock:^(NSDictionary *recomend) {

        }];
        _marketTradingCenterView.frame = CGRectMake(0, _marketCollectionView.bottom+10, self.view.width, 186);

    }
    return _marketTradingCenterView;
}


-(void)setZHScrollViewLB:(NSArray*)array{

    if (_zhScrollViewLB) {
        _zhScrollViewLB=nil;
    }

    _zhScrollViewLB = [[ZHScrollViewLB alloc]initWithFrame:_marketTradingCenterView.headlineContentView.bounds WithImageName:array WithTime:3];
    _zhScrollViewLB.showsVerticalScrollIndicator = FALSE;
    _zhScrollViewLB.showsHorizontalScrollIndicator = FALSE;
    _zhScrollViewLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headlineContentTap:)];
    [_marketTradingCenterView.headlineBgContentView addGestureRecognizer:tap1];
    [_marketTradingCenterView.headlineContentView addSubview:_zhScrollViewLB];


}
// 四版头条点击事件
- (void)headlineContentTap:(UITapGestureRecognizer *)tap
{

}


- (ProjectViewModel *)projectViewModel {

    if (!_projectViewModel) {
        _projectViewModel = [ProjectViewModel new];
    }
    return _projectViewModel;
}


@end
