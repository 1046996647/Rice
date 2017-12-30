//
//  PaymentOrderVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "UnpayOrderVC.h"
#import "OrderHeaderView.h"
#import "BookHeaderView.h"
#import "OrderDetailOneCell.h"
#import "OrderDetailTwoCell.h"
#import "UILabel+WLAttributedString.h"
#import "MarkVC.h"
#import "NSStringExt.h"
#import "PayMentModel.h"
#import "OYCountDownManager.h"
#import "PayModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"

NSString *const OYMultipleTableSource1 = @"OYMultipleTableSource1";


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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [kCountDownManager removeSourceWithIdentifier:OYMultipleTableSource1];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self getOrderByOrderId];
    

}

- (void)initView
{
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-45) style:UITableViewStyleGrouped];
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
    
    
    UIButton *yuEBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-9-52, yuElab1.center.y-12, 52, 24) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"" normal:@"Group 4" selected:@"Group 3-1"];
    [yuEView addSubview:yuEBtn];
    
    
    if (self.payMentModel.priceAll.useBalance.boolValue) {
        yuEView.height = yuEWhiteView.bottom;
        yuEBtn.hidden = YES;
        
        yuElab1.text = @"余额";
        
        UILabel *useBalanceLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-120-14, 0, 120, yuEWhiteView.height) text:[NSString stringWithFormat:@"￥-%@",self.payMentModel.priceAll.useBalance] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [yuEWhiteView addSubview:useBalanceLab];
        [useBalanceLab wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:[NSString stringWithFormat:@"-%@",self.payMentModel.priceAll.useBalance]];

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
    
    
    if (self.payMentModel.priceAll.useCoupon.boolValue) {
        liJinView.height = liJinWhiteView.bottom;
        liJinBtn.hidden = YES;
        liJinlab1.text = @"礼金券可抵扣";

        UILabel *useCouponLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-120-14, 0, 120, liJinWhiteView.height) text:[NSString stringWithFormat:@"￥-%@",self.payMentModel.priceAll.useCoupon] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [liJinWhiteView addSubview:useCouponLab];
        [useCouponLab wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:[NSString stringWithFormat:@"-%@",self.payMentModel.priceAll.useCoupon]];
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
        
        markBtn.hidden = YES;

        self.marklab1.text = self.payMentModel.remarks;
        CGSize size = [NSString textHeight:self.marklab1.text font:self.marklab1.font width:self.marklab1.width];
        if (size.height+20 > self.markWhiteView.height) {
            
            self.marklab1.height = size.height;
            self.markWhiteView.height = 20+size.height;
            self.markView.height = self.markWhiteView.bottom;
            
        }
        else {
            markView.height = markWhiteView.bottom;
            
        }
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
        
        // 余额足够
        if (self.payMentModel.priceAll.payMoney.integerValue == 0) {
            self.payType = @"";
        }
        
        
        //支付成功通知事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"kPaySuccessNotification" object:nil];
        
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
        
        // 启动倒计时管理
        [kCountDownManager start];
        
        self.payMentModel.countDownSource = OYMultipleTableSource1;
        // 增加倒计时源
        [kCountDownManager addSourceWithIdentifier:OYMultipleTableSource1];
    }
    


}


#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    
    NSInteger timeInterval;
    if (self.payMentModel.countDownSource) {
        timeInterval = [kCountDownManager timeIntervalWithIdentifier:self.payMentModel.countDownSource];
    }else {
        timeInterval = kCountDownManager.timeInterval;
    }
    NSInteger countDown = self.payMentModel.restSeconds - timeInterval;
    
    if (countDown > 0) {
        
        [self.payBtn setTitle:[self ll_timeWithSecond:countDown] forState:UIControlStateNormal];
        
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];

    }
}

//将秒数转换为字符串格式
- (NSString *)ll_timeWithSecond:(NSInteger)second
{
    NSString *time;
    
    if (self.payMentModel.priceAll.payMoney.integerValue == 0) {
        time = [NSString stringWithFormat:@"(%02ld分%02ld秒)确认支付",second/60,second%60];
    }
    else {
        time = [NSString stringWithFormat:@"(%02ld分%02ld秒)￥%@确认支付",second/60,second%60,self.payMentModel.priceAll.payMoney];

    }
    
    return time;
}

- (void)payAction
{

    [self payOrder];

}

// 3.3    支付
- (void)payOrder
{
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [paramDic setValue:self.orderId forKey:@"orderId"];
    [paramDic setValue:self.payMentModel.priceAll.payMoney forKey:@"payMoney"];
    
    //    self.param = paramDic;
    if ([self.payType isEqualToString:@"wxpay"]) {
        [paramDic setValue:self.payType forKey:@"payType"];
        [paramDic setValue:[NSString getIPAddress:YES] forKey:@"spbill_create_ip"];
        
    }
    else if ([self.payType isEqualToString:@"alipay"]) {
        [paramDic setValue:self.payType forKey:@"payType"];
        
    }
    else {
        [paramDic setValue:@"" forKey:@"payType"];
        
    }
    
    NSString *urlStr = nil;
    if ([self.title isEqualToString:@"预定支付订单"]) {
        
        urlStr = PayReserveOrder;
    }
    else {
        urlStr = PayOrder2;

    }
    
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        PayModel *model = [PayModel yy_modelWithJSON:responseObject[@"data"]];
        if ([model.payType isEqualToString:@"wxpay"]) {
            
            //需要创建这个支付对象
            PayReq *req = [[PayReq alloc] init];
            //应用id
            req.openID = model.appid;
            
            // 商家商户号
            req.partnerId = model.mch_id;
            
            // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
            req.prepayId = model.prepay_id;//self.orderWithWX.prepayid;
            
            // 根据财付通文档填写的数据和签名
            //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
            req.package = @"Sign=WXPay";
            
            // 随机编码，为了防止重复的，在后台生成
            req.nonceStr = model.nonce_str;//self.orderWithWX.noncestr;
            
            // 这个是时间戳，也是在后台生成的，为了验证支付的
            int timesta = [model.timestamp intValue];
            UInt32 timestamp = (UInt32)timesta;
            req.timeStamp = timestamp;
            
            // 这个签名也是后台做的
            req.sign = model.sign;//self.orderWithWX.sign;
            
            //发送请求到微信，等待微信返回onResp
            [WXApi sendReq:req];
            
            
        }
        else if ([model.payType isEqualToString:@"alipay"]) {
            
            [[AlipaySDK defaultService] payOrder:model.payStr fromScheme:@"Rice" callback:^(NSDictionary *resultDic) {
                //                if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                //                    //9000为支付成功
                //
                //                    NSLog(@"支付成功");
                //                    [self.navigationController popViewControllerAnimated:YES];
                //
                //                }
            }];
        }
        else {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)paySuccess
{
    if (self.mark == 0) {
        
        //进行中订单状态更新通知事件
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"kSendingOrderNotification" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
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

// 重写back
- (void)back{
    if (self.mark == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    else {
        [self.navigationController popViewControllerAnimated:YES];

    }
//    [self.navigationController popViewControllerAnimated:YES];

}

@end

