//
//  BookOrderVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookOrderVC.h"
#import "BookOrderCell.h"
#import "UnpayOrderVC.h"

#import "OYCountDownManager.h"

NSString *const OYMultipleTableSource2 = @"OYMultipleTableSource2";

@interface BookOrderVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic,assign) BOOL isRefresh;
@end

@implementation BookOrderVC

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
    
    [self getReserveOrder];
    
    
    // 启动倒计时管理
    [kCountDownManager start];
    
    // 增加倒计时源
    [kCountDownManager addSourceWithIdentifier:OYMultipleTableSource2];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //进行中订单状态更新通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(headerRefresh) name:@"kSendingOrderNotification" object:nil];
    
}

- (void)headerRefresh
{
    
    [self getReserveOrder];
}

// 3.6    我的订单-进行中订单
- (void)getReserveOrder
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetReserveOrder dic:paramDic showHUD:NO response:YES Succed:^(id responseObject) {
        
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
        // 调用reload, 指定identifier
        [kCountDownManager reloadSourceWithIdentifier:OYMultipleTableSource2];
        
        id obj = responseObject[@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in obj) {
            PayMentModel *model = [PayMentModel yy_modelWithJSON:dic];
            model.countDownSource = OYMultipleTableSource2;
            [arrM addObject:model];
            
        }
        self.dataArr = arrM;
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    BookOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[BookOrderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    PayMentModel *model = _dataArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PayMentModel *model = self.dataArr[indexPath.row];
    
    UnpayOrderVC *vc = [[UnpayOrderVC alloc] init];
    vc.title = @"预定支付订单";
    vc.orderId = model.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
