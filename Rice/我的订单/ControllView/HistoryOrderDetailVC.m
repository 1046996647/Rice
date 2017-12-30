//
//  OrderDetailVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HistoryOrderDetailVC.h"
#import "OrderHeaderView.h"
#import "OrderDetailOneCell.h"
#import "OrderDetailTwoCell.h"
#import "OrderHeaderView.h"
#import "BookHeaderView.h"
#import "EvaluateVC.h"


@interface HistoryOrderDetailVC ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) PayMentModel *payMentModel;
@property (nonatomic,strong) NSMutableArray *selectedArr;


@end

@implementation HistoryOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getOrderByOrderId];

}

// 3.7    获取单个订单信息
- (void)getOrderByOrderId
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [paramDic setValue:self.payMentModel1.orderId forKey:@"orderId"];
    [AFNetworking_RequestData requestMethodPOSTUrl:GetOrderByOrderId dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        //        [_tableView removeFromSuperview];
        
        self.dataArr = [NSMutableArray array];
        self.selectedArr = [NSMutableArray array];
        
        NSMutableArray *mainArr = [NSMutableArray array];//主食
        NSMutableArray *arrM = [NSMutableArray array];// 附加
        
        
        NSDictionary *dic = responseObject[@"data"];
        PayMentModel *payMentModel = [PayMentModel yy_modelWithJSON:dic];
        self.payMentModel = payMentModel;
        
        for (FoodModel1 *model in payMentModel.listFoods) {
            
            if (model.isMain.boolValue) {
                [mainArr addObject:model];
                
            }
            else {
                if (model.amount.integerValue > 0) {
                    [arrM addObject:model];
                    
                }
                
            }
            //            [self.selectedArr addObject:model];
        }
        [self.dataArr addObject:mainArr];
        
        if (arrM.count > 0) {
            [self.dataArr addObject:arrM];
            
        }
        
        
        [self initView];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)initView
{
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.payMentModel.isActual) {
        
        // 头视图
        OrderHeaderView *headerView = [[OrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        headerView.userAddressModel = self.payMentModel.userAddress;
        headerView.baseView.userInteractionEnabled = NO;
        headerView.addressImg.hidden = YES;
        _tableView.tableHeaderView = headerView;

    }
    else {
        // 头视图
        BookHeaderView *headerView = [[BookHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        headerView.time = self.payMentModel.timeArea;
        headerView.payMentModel = self.payMentModel;
        headerView.userAddressModel = self.payMentModel.userAddress;
        headerView.baseView.userInteractionEnabled = NO;
        headerView.timeLab.userInteractionEnabled = NO;
        headerView.addressImg.hidden = YES;
        _tableView.tableHeaderView = headerView;
    }
    
    if (self.payMentModel1.status.integerValue == 3) {
        
        UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 36, 22) text:@"评价" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
        [viewBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
    }
    
    if (self.payMentModel1.status.integerValue == 8) {
        
        _tableView.height = kScreenHeight-kTopHeight-45;
        UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, _tableView.bottom, kScreenWidth, 45) text:@"通知回收" font:SystemFont(17) textColor:@"#444444" backgroundColor:@"#F8E249" normal:nil selected:nil];
        [viewBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:viewBtn];
    }

}

- (void)evaluateAction:(UIButton *)btn
{
    
    if ([btn.currentTitle isEqualToString:@"评价"]) {
        
        EvaluateVC *vc = [[EvaluateVC alloc] init];
        vc.title = btn.currentTitle;
        vc.orderId = self.payMentModel1.orderId;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^{
            self.payMentModel1.status = @"7";
            self.navigationItem.rightBarButtonItem = nil;
        };
    }
    else {
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:self.payMentModel1.orderId forKey:@"orderId"];
        [AFNetworking_RequestData requestMethodPOSTUrl:RequestRecovery dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            self.payMentModel1.status = @"9";
            [self.view makeToast:@"已发送回收通知"];

//            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            
            
        }];

    }

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
//    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
//    return 2;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 70;
    }
    else {
        return 41;

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0001;
    }
    else {
        return 34;
        
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    else {
        UILabel *nameLab = [UILabel labelWithframe:CGRectMake(0, 0, kScreenWidth, 34) text:@"      附加饮品" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        return nameLab;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodModel1 *model = self.dataArr[indexPath.section][indexPath.row];

    if (indexPath.section == 0) {
        
        OrderDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        if (cell == nil) {
            
            cell = [[OrderDetailOneCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:@"oneCell"];
            
        }
        cell.model = model;

        return cell;
    }
    else {
        OrderDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        if (cell == nil) {
            
            cell = [[OrderDetailTwoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:@"twoCell"];
            
        }
        
        if (indexPath.row == 1) {
            cell.line.hidden = YES;
        }
        else {
            cell.line.hidden = NO;
            
        }
        cell.model = model;

        return cell;
    }
    return nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
