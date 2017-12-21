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
#import "NSStringExt.h"
#import "PayMentModel.h"
#import <AlipaySDK/AlipaySDK.h>


@interface PaymentOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *selectedArr;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *footerView;
@property(nonatomic,strong) PayMentModel *payMentModel;
@property(nonatomic,strong) NSString *orderId;

@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) UIButton *lastBtn;


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

    NSString *ipStr = [NSString getIPAddress:YES];


    [self toPayPage:ToPayPage];
}

- (void)initView
{
    // 头视图
    OrderHeaderView *headerView = [[OrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headerView.userAddressModel = self.payMentModel.userAddress;
    
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
    
    
    UIButton *yuEBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-52, yuElab1.center.y-12, 52, 24) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Group 3-1" selected:@"Group 4"];
    [yuEView addSubview:yuEBtn];
    [yuEBtn addTarget:self action:@selector(yuEAction) forControlEvents:UIControlEventTouchUpInside];


    if (self.payMentModel.balance.boolValue) {
        yuEView.height = yuEWhiteView.bottom;
        yuElab1.text = [NSString stringWithFormat:@"余额：￥%@",self.payMentModel.balance];
        [yuElab1 wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:[NSString stringWithFormat:@"￥%@",self.payMentModel.balance]];
        
        yuEBtn.selected = self.payMentModel.isUseBalance;

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
    
    
    UIButton *liJinBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-52, yuElab1.center.y-12, 52, 24) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Group 3-1" selected:@"Group 4"];
    [liJinView addSubview:liJinBtn];
    [liJinBtn addTarget:self action:@selector(liJinAction) forControlEvents:UIControlEventTouchUpInside];


    if (self.payMentModel.coupon.boolValue) {
        liJinView.height = liJinWhiteView.bottom;
        liJinlab1.text = [NSString stringWithFormat:@"礼金券可抵扣：￥%@",self.payMentModel.coupon];
        [liJinlab1 wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:[NSString stringWithFormat:@"￥%@",self.payMentModel.coupon]];
        
        liJinBtn.selected = self.payMentModel.isUseBalance;
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
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(markAction)];
    [markWhiteView addGestureRecognizer:tap];
    
    UIButton *markBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-12, 12, 9, 15) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Back Chevron Copy 2" selected:@""];
    [markWhiteView addSubview:markBtn];
    
    UILabel *marklab1 = [UILabel labelWithframe:CGRectMake(marklab.left, marklab.bottom+17, markBtn.left-10-(marklab.left), 20) text:@"口味、偏好等要求" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
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
    
    payView.height = aliBtn.bottom+17;
    
    footerView.height = payView.bottom;
    _tableView.tableFooterView = footerView;
    

    // !!!!确认支付
    UIButton *payBtn = [UIButton buttonWithframe:CGRectMake(0, _tableView.bottom, kScreenWidth, 45) text:[NSString stringWithFormat:@"￥%@     确认支付",self.payMentModel.priceAll.payMoney] font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#F8E249" normal:nil selected:nil];
    [self.view addSubview:payBtn];
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.payMentModel.priceAll.payMoney.integerValue == 0) {
        [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    }
    
}


- (void)yuEAction
{
    
    if (self.payMentModel.isUseBalance) {
        [self.param setValue:@"0" forKey:@"isUseBalance"];
        
    }
    else {
        [self.param setValue:@"1" forKey:@"isUseBalance"];
        
    }
    [self modifyOrder];
}

- (void)liJinAction
{
    if (self.payMentModel.isUseCoupon) {
        [self.param setValue:@"0" forKey:@"isUseBalance"];
        
    }
    else {
        [self.param setValue:@"1" forKey:@"isUseBalance"];
        
    }
    [self modifyOrder];
}

- (void)payAction
{
    if (!self.payMentModel.userAddress) {
        [self.view makeToast:@"请添加地址"];
        return;
    }
    
    [self createOrder];
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

// 2.2    订单生成
- (void)toPayPage:(NSString *)urlStr
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:self.param showHUD:NO response:NO Succed:^(id responseObject) {
        
        [_tableView removeFromSuperview];
        
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
                [arrM addObject:model];

            }
            [self.selectedArr addObject:model];
        }
        [self.dataArr addObject:mainArr];
        [self.dataArr addObject:arrM];

        
        [self initView];
        
    } failure:^(NSError *error) {
        
    }];
}

// 重新生成订单
- (void)modifyOrder
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (FoodModel1 *model in self.selectedArr) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.foodId,@"foodId", model.amount,@"amount", nil];
        [arrM addObject:paramDic];
        
    }
    
//    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSString *jsonStr = [NSString JSONString:arrM];
    [self.param setValue:jsonStr forKey:@"listFoods"];
    
    
//    self.param = paramDic;
    
    [self toPayPage:PlaceOrder];
    
    NSLog(@"paramDic:%@",self.param);
}

// 3.2    创建未支付订单
- (void)createOrder
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (FoodModel1 *model in self.selectedArr) {
        if (model.amount.integerValue > 0) {
            NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.foodId,@"foodId", model.amount,@"amount", nil];
            [arrM addObject:paramDic];
        }

    }
    
    NSString *jsonStr = [NSString JSONString:arrM];
    [self.param setValue:jsonStr forKey:@"listFoods"];
    
    [self.param setValue:self.payMentModel.userAddress.addressId forKey:@"addressId"];
    [self.param setValue:self.payType forKey:@"payType"];
    [self.param setValue:self.payMentModel.priceAll.payMoney forKey:@"payMoney"];
    
    if (self.payMentModel.balance.integerValue > 0) {
        [self.param setValue:@"1" forKey:@"isUseBalance"];
        
    }
    else {
        [self.param setValue:@"0" forKey:@"isUseBalance"];
        
    }
    if (self.payMentModel.coupon.integerValue > 0) {
        [self.param setValue:@"1" forKey:@"isUseCoupon"];
        
    }
    else {
        [self.param setValue:@"0" forKey:@"isUseCoupon"];
        
    }

    if (![self.marklab1.text isEqualToString:@"口味、偏好等要求"]) {
        [self.param setValue:self.marklab1.text forKey:@"remarks"];

    }
    
//    self.param = paramDic;
    
//    NSLog(@"paramDic:%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:CreateOrder dic:self.param showHUD:YES response:NO Succed:^(id responseObject) {
        

        
        self.orderId = responseObject[@"data"][@"orderId"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定支付" message:nil preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self payOrder];
            
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        //退出登录或下未支付订单通知事件
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kExitOrOrderNotification" object:nil];

        
    } failure:^(NSError *error) {
        
    }];
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

    self.param = paramDic;

    NSLog(@"paramDic:%@",paramDic);

    [AFNetworking_RequestData requestMethodPOSTUrl:PayOrder dic:self.param showHUD:YES response:NO Succed:^(id responseObject) {

        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {

    }];
    
//    [AFNetworking_RequestData requestMethodPOSTUrl:@"http://106.14.218.31:61/api/test1/alipaytest" dic:nil showHUD:YES response:NO Succed:^(id responseObject) {
//
//        NSString *orderString = responseObject[@"data"][@"payStr"];
//
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"Rice" callback:^(NSDictionary *resultDic) {
//            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
//                //9000为支付成功
//
//                NSLog(@"支付成功");
//                [self.navigationController popViewControllerAnimated:YES];
//
//            }
//        }];
//
//
//    } failure:^(NSError *error) {
//
//    }];
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
        
        if (size.height+20 > self.markWhiteView.height) {
            
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
        OrderDetailTwoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        if (cell == nil) {
            
            cell = [[OrderDetailTwoCell1 alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:@"twoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.block = ^(FoodModel1 *model) {
                
                if (self.payMentModel.isUseBalance) {
                    [self.param setValue:@"1" forKey:@"isUseBalance"];
                    
                }
                else {
                    [self.param setValue:@"0" forKey:@"isUseBalance"];
                    
                }
                if (self.payMentModel.isUseCoupon) {
                    [self.param setValue:@"1" forKey:@"isUseCoupon"];
                    
                }
                else {
                    [self.param setValue:@"0" forKey:@"isUseCoupon"];
                    
                }
                
                [self modifyOrder];
            };
            
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
