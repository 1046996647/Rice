//
//  SystemMassageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SystemMassageVC.h"
#import "SystemMassageCell.h"
#import "SystemModel.h"
#import "SystemMsgDetailVC.h"

@interface SystemMassageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger pageNO;
@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation SystemMassageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
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
            [self getAricleList];
        }
        
    }];
    
    self.pageNO = 1;
    self.dataArr = [NSMutableArray array];
    [self getAricleList];
    
    [self setUserClicked];
    
    
}

- (void)headerRefresh
{
    
    self.pageNO = 1;
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
        
    }
    [self getAricleList];
    
}

// 3.7    获取消息
- (void)getAricleList
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic setValue:@(self.pageNO) forKey:@"pageIndex"];

    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetAricleList dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        id obj = responseObject[@"data"];
        if ([obj count]) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in obj) {
                SystemModel *model = [SystemModel yy_modelWithJSON:dic];
                
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

- (void)setUserClicked
{
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SetUserClicked dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kRedDotNotification" object:nil];

        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
//    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 16+228;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SystemModel *model = self.dataArr[indexPath.row];

    SystemMsgDetailVC *vc = [[SystemMsgDetailVC alloc] init];
    vc.url = model.articleUrl;
    vc.title = @"消息详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SystemMassageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[SystemMassageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataArr.count > 0) {
        
        cell.model = _dataArr[indexPath.row];
        
    }
    
    return cell;
}
@end
