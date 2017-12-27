//
//  RechargeVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RechargeVC.h"
#import "PayModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface RechargeVC ()

@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) UITextField *countTF;

@end

@implementation RechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 支付方式
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [self.view addSubview:payView];
    //    self.payView = payView;
    
    // 微信支付
    UIButton *wechatBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 52) text:@"" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#ffffff" normal:@"Oval 4" selected:@"选中的勾"];
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
    
    payView.height = aliBtn.bottom;
    
    // 账号
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, payView.bottom+10, kScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *countLab = [UILabel labelWithframe:CGRectMake(20, 16, 60, 20) text:@"充值金额" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [view addSubview:countLab];
    
    _countTF = [UITextField textFieldWithframe:CGRectMake(countLab.right+10, 0, kScreenWidth-(countLab.right+10)-10, view.height) placeholder:@"" font:nil leftView:nil backgroundColor:nil];
    _countTF.keyboardType = UIKeyboardTypeDecimalPad;
    [view addSubview:_countTF];
    
    UIButton *okBtn = [UIButton buttonWithframe:CGRectMake(34, view.bottom+27, kScreenWidth-68, 42) text:@"充值" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    okBtn.layer.cornerRadius = 7;
    okBtn.layer.masksToBounds = YES;
    [self.view addSubview:okBtn];
    [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    //支付成功通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"kPaySuccessNotification" object:nil];
}

- (void)paySuccess
{
    
    //充值或提现成功通知事件
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kchargeOrDepositSuccessNotification" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)okAction
{
    if (_countTF.text.length == 0) {
        [self.view makeToast:@"请输入金额"];
        return;
    }
    
    [self payOrder];
}

// 3.3    支付
- (void)payOrder
{
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [paramDic setValue:_countTF.text forKey:@"payMoney"];
    
    //    self.param = paramDic;
    if ([self.payType isEqualToString:@"wxpay"]) {
        [paramDic setValue:self.payType forKey:@"payType"];
        [paramDic setValue:[NSString getIPAddress:YES] forKey:@"spbill_create_ip"];
        
    }
    else if ([self.payType isEqualToString:@"alipay"]) {
        [paramDic setValue:self.payType forKey:@"payType"];
        
    }
    
    NSLog(@"paramDic:%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Charge dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
