//
//  PaymentOrderVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "UnpayOrderVC.h"
#import "OrderHeaderView.h"
#import "OrderDetailOneCell.h"
#import "OrderDetailTwoCell.h"
#import "UILabel+WLAttributedString.h"
#import "MarkVC.h"
#import "NSStringExt.h"
#import "PayMentModel.h"

@interface UnpayOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *selectedArr;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *footerView;
@property(nonatomic,strong) PayMentModel *payMentModel;

@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) UIButton *payBtn;


// 备注
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UIView *markWhiteView;
@property(nonatomic,strong) UILabel *marklab1;

// 支付方式
@property(nonatomic,strong) UIView *payView;


@end

@implementation UnpayOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self getOrderByOrderId];
}

- (void)initView
{
    // 头视图
    OrderHeaderView *headerView = [[OrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headerView.userAddressModel = self.payMentModel.userAddress;
    headerView.baseView.userInteractionEnabled = NO;
    headerView.addressImg.hidden = YES;
    
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
    
    
    if (self.payMentModel.useBalance.boolValue) {
        yuEView.height = yuEWhiteView.bottom;
    }
    else {
        yuEView.hidden = YES;
//        yuEView.bottom = 0;
        
    }
    
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
    
    
    if (self.payMentModel.useCoupon.boolValue) {
        liJinView.height = liJinWhiteView.bottom;
        
    }
    else {
        liJinView.hidden = YES;
//        liJinView.bottom = 0;
    }
    
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
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(markAction)];
//    [markWhiteView addGestureRecognizer:tap];
    
    UIButton *markBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-12, 12, 9, 15) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Back Chevron Copy 2" selected:@""];
    [markWhiteView addSubview:markBtn];
    
    UILabel *marklab1 = [UILabel labelWithframe:CGRectMake(marklab.left, marklab.bottom+17, markBtn.left-10-(marklab.left), 20) text:@"口味、偏好等要求" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [markView addSubview:marklab1];
    self.marklab1 = marklab1;
    marklab1.numberOfLines = 0;
    
    if (self.payMentModel.remarks.length > 0) {
        markView.height = markWhiteView.bottom;
        marklab1.text = self.payMentModel.remarks;
        markBtn.hidden = YES;
    }
    else {
        markView.hidden = YES;
//        markView.bottom = 0;
    }
    
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
    [wechatBtn addTarget:self action:@selector(payWayAction:) forControlEvents:UIControlEventTouchUpInside];
    wechatBtn.tag = 0;
    
    // 默认微信支付
    self.lastBtn = wechatBtn;
    self.payType = @"wxpay";
    
    
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
    [aliBtn addTarget:self action:@selector(payWayAction:) forControlEvents:UIControlEventTouchUpInside];
    aliBtn.tag = 1;
    
    
    UIButton *aliBtn1 = [UIButton buttonWithframe:CGRectMake(21, 0, 200, 52) text:@"支付宝支付" font:SystemFont(14) textColor:@"#333333" backgroundColor:@"#ffffff" normal:@"25" selected:@""];
    [aliBtn addSubview:aliBtn1];
    aliBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    aliBtn1.titleEdgeInsets = UIEdgeInsetsMake(0, 22, 0, 0);
    aliBtn1.userInteractionEnabled = NO;
    
    if (self.payMentModel.priceAll.payMoney.boolValue) {
        payView.height = aliBtn.bottom+17;

    }
    else {
        payView.hidden = YES;
        //        markView.bottom = 0;
    }
    
    footerView.height = payView.bottom;
    
    
    _tableView.tableFooterView = footerView;
    
    
    // !!!!确认支付
    UIButton *payBtn = [UIButton buttonWithframe:CGRectMake(0, _tableView.bottom, kScreenWidth, 45) text:[self ll_timeWithSecond:self.payMentModel.restSeconds] font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#F8E249" normal:nil selected:nil];
    [self.view addSubview:payBtn];
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    self.payBtn = payBtn;
    
    if (self.payMentModel.status.integerValue != 0) {
        payBtn.hidden = YES;
        
    }
    else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
        //将定时器加入NSRunLoop，保证滑动表时，UI依然刷新
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    


}

- (void)timerRun:(NSTimer *)timer {
    
    if (self.payMentModel.restSeconds > 0) {
        
        [self.payBtn setTitle:[self ll_timeWithSecond:self.payMentModel.restSeconds] forState:UIControlStateNormal];
        self.payMentModel.restSeconds -= 1;
    }
    else {
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//将秒数转换为字符串格式
- (NSString *)ll_timeWithSecond:(NSInteger)second
{
    NSString *time;
    time = [NSString stringWithFormat:@"(%02ld分%02ld秒)￥%@确认支付",second/60,second%60,self.payMentModel.priceAll.payMoney];
    
    return time;
}

- (void)payAction
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定支付" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self payOrder];
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 3.3    支付
- (void)payOrder
{
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    //    [paramDic setValue:self.payMentModel.priceAll.useBalance forKey:@"useBalance"];
    //    [paramDic setValue:self.payMentModel.priceAll.useCoupon forKey:@"useCoupon"];
    
    [paramDic setValue:self.orderId forKey:@"orderId"];
    [paramDic setValue:self.payType forKey:@"payType"];
    [paramDic setValue:self.payMentModel.priceAll.payMoney forKey:@"payMoney"];
    
    
    NSLog(@"paramDic:%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:PayOrder dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)payWayAction:(UIButton *)btn
{
    self.lastBtn.selected = NO;
    btn.selected = YES;
    if (btn.tag == 0) {
        self.payType = @"wxpay";
    }
    else {
        self.payType = @"alipay";
        
    }
    self.lastBtn = btn;
}

// 3.7    获取单个订单信息
- (void)getOrderByOrderId
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [paramDic setValue:self.orderId forKey:@"orderId"];
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = model;
        return cell;
    }
    else {
        OrderDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        if (cell == nil) {
            
            cell = [[OrderDetailTwoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:@"twoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        if (indexPath.row == [self.dataArr[indexPath.section] count]-1) {
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

