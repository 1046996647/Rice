//
//  PaymentOrderVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PaymentOrderVC.h"
#import "OrderHeaderView.h"
#import "OrderDetailOneCell.h"
#import "OrderDetailTwoCell1.h"
#import "UILabel+WLAttributedString.h"
#import "MarkVC.h"
#import "NSStringExt.h"

@interface PaymentOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *footerView;


// 备注
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UIView *markWhiteView;
@property(nonatomic,strong) UILabel *marklab1;

// 支付方式
@property(nonatomic,strong) UIView *payView;


@end

@implementation PaymentOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // 头视图
    OrderHeaderView *headerView = [[OrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headerView.addressImg.hidden = NO;
    headerView.moneyLab.hidden = YES;
    headerView.userInteractionEnabled = YES;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-45) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.tableHeaderView = headerView;
    
    // -------尾视图--------
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    self.footerView = footerView;
    
    // 余额
    UIView *yuEView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [footerView addSubview:yuEView];
    
    UILabel *yuElab = [UILabel labelWithframe:CGRectMake(24, 7, 100, 20) text:@"使用余额" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [yuEView addSubview:yuElab];
    
    UIView *yuEWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, yuElab.bottom+7, kScreenWidth, 40)];
    yuEWhiteView.backgroundColor = [UIColor whiteColor];
    [yuEView addSubview:yuEWhiteView];

    
    UILabel *yuElab1 = [UILabel labelWithframe:CGRectMake(yuElab.left, yuElab.bottom+17, 300, 20) text:@"余额：￥20.00" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [yuEView addSubview:yuElab1];
    [yuElab1 wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:@"￥20.00"];

    
    UIButton *yuEBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-52, yuElab1.center.y-12, 52, 24) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Group 4" selected:@"Group 3-1"];
    [yuEView addSubview:yuEBtn];
    
    yuEView.height = yuEWhiteView.bottom;
    
    
    // 礼金券
    UIView *liJinView = [[UIView alloc] initWithFrame:CGRectMake(0, yuEView.bottom, kScreenWidth, 0)];
    [footerView addSubview:liJinView];
    
    UILabel *liJinlab = [UILabel labelWithframe:CGRectMake(24, 7, 200, 20) text:@"使用礼金券金额抵扣" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [liJinView addSubview:liJinlab];
    
    UIView *liJinWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, liJinlab.bottom+7, kScreenWidth, 40)];
    liJinWhiteView.backgroundColor = [UIColor whiteColor];
    [liJinView addSubview:liJinWhiteView];
    
    
    UILabel *liJinlab1 = [UILabel labelWithframe:CGRectMake(yuElab.left, liJinlab.bottom+17, 300, 20) text:@"礼金券可抵扣：￥12.80" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [liJinView addSubview:liJinlab1];
    [liJinlab1 wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:@"￥12.80"];
    
    
    UIButton *liJinBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-52, yuElab1.center.y-12, 52, 24) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Group 4" selected:@"Group 3-1"];
    [liJinView addSubview:liJinBtn];
    
    liJinView.height = liJinWhiteView.bottom;
    
    // 备注
    UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(0, liJinView.bottom, kScreenWidth, 0)];
    [footerView addSubview:markView];
    self.markView = markView;
    
    UILabel *marklab = [UILabel labelWithframe:CGRectMake(24, 7, 100, 20) text:@"备注" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [markView addSubview:marklab];
    
    UIView *markWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, marklab.bottom+7, kScreenWidth, 40)];
    markWhiteView.backgroundColor = [UIColor whiteColor];
    [markView addSubview:markWhiteView];
    self.markWhiteView = markWhiteView;

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(markAction)];
    [markWhiteView addGestureRecognizer:tap];
    
    UIButton *markBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-12, 12, 9, 15) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Back Chevron Copy 2" selected:@""];
    [markWhiteView addSubview:markBtn];
    
    UILabel *marklab1 = [UILabel labelWithframe:CGRectMake(yuElab.left, marklab.bottom+17, markBtn.left-10-(yuElab.left), 20) text:@"口味、偏好等要求" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [markView addSubview:marklab1];
    self.marklab1 = marklab1;
    marklab1.numberOfLines = 0;
    
    markView.height = markWhiteView.bottom;
    
    // 支付方式
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, markView.bottom, kScreenWidth, 0)];
    [footerView addSubview:payView];
    self.payView = payView;

    
    UILabel *paylab = [UILabel labelWithframe:CGRectMake(24, 7, 100, 20) text:@"支付方式" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [payView addSubview:paylab];
    
    // 微信支付
    UIButton *wechatBtn = [UIButton buttonWithframe:CGRectMake(0, paylab.bottom+7, kScreenWidth, 52) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#ffffff" normal:@"Oval 4" selected:@"选中的勾"];
    [payView addSubview:wechatBtn];
    wechatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    wechatBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    wechatBtn.selected = YES;
    
    UIButton *wechatBtn1 = [UIButton buttonWithframe:CGRectMake(21, 0, 200, 52) text:@"微信支付" font:SystemFont(14) textColor:@"#333333" backgroundColor:@"#ffffff" normal:@"24" selected:@""];
    [wechatBtn addSubview:wechatBtn1];
    wechatBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    wechatBtn1.titleEdgeInsets = UIEdgeInsetsMake(0, 22, 0, 0);
    wechatBtn1.userInteractionEnabled = NO;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(22, wechatBtn.bottom, kScreenWidth-44, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
    [payView addSubview:line];
    
    // 支付宝
    UIButton *aliBtn = [UIButton buttonWithframe:CGRectMake(0, line.bottom, kScreenWidth, 52) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#ffffff" normal:@"Oval 4" selected:@"选中的勾"];
    [payView addSubview:aliBtn];
    aliBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    aliBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    
    UIButton *aliBtn1 = [UIButton buttonWithframe:CGRectMake(21, 0, 200, 52) text:@"支付宝支付" font:SystemFont(14) textColor:@"#333333" backgroundColor:@"#ffffff" normal:@"25" selected:@""];
    [aliBtn addSubview:aliBtn1];
    aliBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    aliBtn1.titleEdgeInsets = UIEdgeInsetsMake(0, 22, 0, 0);
    aliBtn1.userInteractionEnabled = NO;
    
    payView.height = aliBtn.bottom+17;
    
    footerView.height = payView.bottom;
    _tableView.tableFooterView = footerView;
    
    
    // !!!!支付
    UIButton *payBtn = [UIButton buttonWithframe:CGRectMake(0, _tableView.bottom, kScreenWidth, 45) text:@"￥0.00     确认支付" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#F8E249" normal:nil selected:nil];
    [self.view addSubview:payBtn];
    //    [viewBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self placeOrder];
}

// 2.2    订单生成
- (void)placeOrder
{
    
    
    [AFNetworking_RequestData requestMethodPOSTUrl:PlaceOrder dic:self.param showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
//            NSMutableArray *foodArr = [NSMutableArray array];
//            for (NSDictionary *dic in arr) {
//                FoodModel *model = [FoodModel yy_modelWithJSON:dic];
//                [foodArr addObject:model];
//            }
//            self.foodArrs = foodArr;
//            [_pagerView reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)markAction
{
    MarkVC *vc = [[MarkVC alloc] init];
    vc.title = @"备注";
    vc.text = self.marklab1.text;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *text) {
        
        self.marklab1.text = text;
        CGSize size = [NSString textHeight:text font:self.marklab1.font width:self.marklab1.width];
        
        if (size.height > self.markWhiteView.height) {
            
            self.marklab1.height = size.height;
            self.markWhiteView.height = 20+size.height;
            self.markView.height = self.markWhiteView.bottom;
            
            self.payView.top = self.markView.bottom;
            self.footerView.height = self.payView.bottom;
            _tableView.tableFooterView = self.footerView;
        }
        
    };
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return [self.dataArr count];
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return [self.dataArr[section] count];
    return 2;
    
    
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
    
    if (indexPath.section == 0) {
        
        OrderDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        if (cell == nil) {
            
            cell = [[OrderDetailOneCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:@"oneCell"];
            
        }
        //    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
        //    cell.model = model;
        //    cell.dataArr = _dataArr;
        return cell;
    }
    else {
        OrderDetailTwoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        if (cell == nil) {
            
            cell = [[OrderDetailTwoCell1 alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:@"twoCell"];
            
        }
        
        if (indexPath.row == 1) {
            cell.line.hidden = YES;
        }
        else {
            cell.line.hidden = NO;
            
        }
        //    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
        //    cell.model = model;
        //    cell.dataArr = _dataArr;
        return cell;
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
