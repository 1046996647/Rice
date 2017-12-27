//
//  BalancePaymentDetailVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BalancePaymentDetailVC.h"
#import "BalancePaymentDetailCell.h"

@interface BalancePaymentDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger pageNO;
@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation BalancePaymentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.dataArr.count > 0) {
            [self getPayRecord];
        }
        
    }];
    
    self.pageNO = 1;
    self.dataArr = [NSMutableArray array];
    
    [self getPayRecord];
}

// 4.5    查看收支明细
- (void)getPayRecord
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic setValue:@(self.pageNO) forKey:@"pageIndex"];

    
    NSLog(@"paramDic:%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetPayRecord dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        id obj = responseObject[@"data"];
        if ([obj count]) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in obj) {
                PayRecordModel *model = [PayRecordModel yy_modelWithJSON:dic];
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
//    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"cell";
    BalancePaymentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[BalancePaymentDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    cell.textLabel.text = self.dataArr[indexPath.row];
    if (self.dataArr.count > 0) {
        
        cell.model = _dataArr[indexPath.row];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
