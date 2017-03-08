//
//  TRZXHeadlinesViewController.m
//  TRZXMarket
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXHeadlinesViewController.h"
#import "TRZXHeadlinesViewModel.h"
#import "TRZXKit.h"
#import "TRZXHeadlinesCell.h"
#import "TRZXDIYRefresh.h"
#import <TRZXWebViewCategory/CTMediator+TRZXWebView.h>

@interface TRZXHeadlinesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *headlinesTableView;
@property (strong, nonatomic) TRZXHeadlinesViewModel *headlinesViewModel;
@end

@implementation TRZXHeadlinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle;

    [self.view addSubview:self.headlinesTableView];
    // Do any additional setup after loading the view.
}
- (void)refresh{
    self.headlinesViewModel.willLoadMore = NO;
    [self.headlinesTableView.mj_footer resetNoMoreData];
    [self requestSignal_findPageList];
}

- (void)refreshMore{
    if (!self.headlinesViewModel.canLoadMore) {
        [self.headlinesTableView.mj_footer setState:MJRefreshStateNoMoreData];
        return;
    }
    self.headlinesViewModel.willLoadMore = YES;
    [self requestSignal_findPageList];
}

// 发起请求
- (void)requestSignal_findPageList {


    [self.headlinesViewModel.requestSignal_findPageList subscribeNext:^(id x) {

        // 请求完成后，更新UI

        // 结束刷新状态
        if (self.headlinesViewModel.willLoadMore) {
            [self.headlinesTableView.mj_footer endRefreshing];
        }else{
            [self.headlinesTableView.mj_header endRefreshing];
        }

        [self.headlinesTableView reloadData];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.headlinesViewModel.data.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((9*(self.view.width))/16)+110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TRZXHeadlinesCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TRZXHeadlinesCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier_TRZXHeadlinesCell owner:self options:nil] lastObject];
    }
    TRZXHeadlines *headlines = [self.headlinesViewModel.data objectAtIndex:indexPath.row];
    cell.headlines = headlines;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TRZXHeadlines *headlines = [self.headlinesViewModel.data objectAtIndex:indexPath.row];

    UIViewController *goodsDetailVC = [[CTMediator sharedInstance] webViewControllerWithWebURL:headlines.msgView];
    if (goodsDetailVC) {
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }


}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)headlinesTableView{
    if (!_headlinesTableView) {
        // 内容视图
        _headlinesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _headlinesTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _headlinesTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _headlinesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _headlinesTableView.dataSource = self;
        _headlinesTableView.delegate = self;
        _headlinesTableView.estimatedRowHeight = 316;  //  随便设个不那么离谱的值
        _headlinesTableView.rowHeight = UITableViewAutomaticDimension;
        // 去除顶部空白
        _headlinesTableView.tableHeaderView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
        _headlinesTableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _headlinesTableView.mj_header = [TRZXGifHeader headerWithRefreshingBlock:^{
            // 刷新数据
            [self refresh];
        }];
        [ self.headlinesTableView.mj_header beginRefreshing];

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
        _headlinesTableView.mj_footer = [TRZXGifFooter footerWithRefreshingBlock:^{
            [self refreshMore];

        }];
        _headlinesTableView.mj_footer.automaticallyHidden = YES;

    }
    return _headlinesTableView;
}


- (TRZXHeadlinesViewModel *)headlinesViewModel {

    if (!_headlinesViewModel) {
        _headlinesViewModel = [TRZXHeadlinesViewModel new];
    }
    return _headlinesViewModel;
}

@end
