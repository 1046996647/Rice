//
//  HistoryOrderVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HistoryOrderVC.h"
#import "HistoryOrderCell.h"
#import "HistoryOrderDetailVC.h"

@interface HistoryOrderVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger pageNO;
@property (nonatomic,assign) BOOL isRefresh;
@end

@implementation HistoryOrderVC

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-37) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];

        
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.dataArr.count > 0) {
            // 搜索职位
            [self getHistoryOrder];
        }
        
    }];
    
    self.pageNO = 1;
    self.dataArr = [NSMutableArray array];
    [self getHistoryOrder];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
    
    //完成订单状态更新通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(headerRefresh) name:@"kHistoryOrderNotification" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)headerRefresh
{
    
    self.pageNO = 1;
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
        
    }
    [self getHistoryOrder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 3.6    我的订单-进行中订单
- (void)getHistoryOrder
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic setValue:@(self.pageNO) forKey:@"pageIndex"];

    [AFNetworking_RequestData requestMethodPOSTUrl:GetHistoryOrder dic:paramDic showHUD:NO response:YES Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        id obj = responseObject[@"data"];
        if ([obj count]) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in obj) {
                PayMentModel *model = [PayMentModel yy_modelWithJSON:dic];
                
                [arrM addObject:model];

            }
            [self.dataArr addObjectsFromArray:arrM];
            self.pageNO++;
        }

        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
//    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cell_id = @"cell";
    HistoryOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[HistoryOrderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.block = ^{
            
            [_tableView reloadData];
        };

    }
    if (self.dataArr.count > 0) {

        cell.model = _dataArr[indexPath.row];

    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __block PayMentModel *model = self.dataArr[indexPath.row];
    
    HistoryOrderDetailVC *vc = [[HistoryOrderDetailVC alloc] init];
    vc.title = @"历史订单详情";
    vc.payMentModel1 = model;
    [self.navigationController pushViewController:vc animated:YES];
//    vc.block = ^{
//
//        if (model.status.integerValue == 3) {
//            model.status = @"7";
//        }
//        if (model.status.integerValue == 8) {
//            model.status = @"9";
//        }
//    };
}

@end
