//
//  WithdrawDepositVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "WithdrawDepositVC.h"

@interface WithdrawDepositVC ()

@property(nonatomic,strong) NSString *takeType;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) UITextField *countTF;
@property(nonatomic,strong) UITextField *moneyTF;

@end

@implementation WithdrawDepositVC

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
    self.takeType = @"wxpay";
    
    
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
    
    UILabel *countLab = [UILabel labelWithframe:CGRectMake(20, 16, 32, 20) text:@"账号" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [view addSubview:countLab];
    
    _countTF = [UITextField textFieldWithframe:CGRectMake(countLab.right+10, 0, kScreenWidth-(countLab.right+10)-10, view.height) placeholder:@"" font:nil leftView:nil backgroundColor:nil];
//    _phone.keyboardType = UIKeyboardTypeNumberPad;
    [view addSubview:_countTF];
    
    
    // 提现
    view = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom+10, kScreenWidth, 137)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *titleLab = [UILabel labelWithframe:CGRectMake(18, 12, 60, 20) text:@"提现金额" font:[UIFont boldSystemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [view addSubview:titleLab];    line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];

    
    UILabel *titleLab1 = [UILabel labelWithframe:CGRectMake(22, titleLab.bottom+17, 38, 48) text:@"￥" font:[UIFont boldSystemFontOfSize:34] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [view addSubview:titleLab1];
    
    _moneyTF = [UITextField textFieldWithframe:CGRectMake(titleLab1.right+10, titleLab1.top, kScreenWidth-(titleLab1.right+10)-10, titleLab1.height) placeholder:@"" font:titleLab1.font leftView:nil backgroundColor:nil];
    _moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    [view addSubview:_moneyTF];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, _moneyTF.bottom+11, kScreenWidth, 1)];
    [view addSubview:line];
    
    
    NSString *money = [NSString stringWithFormat:@"可用余额 %@元",self.yuE];
    UILabel *yuELab = [UILabel labelWithframe:CGRectMake(9, line.bottom+5, 120, 17) text:money font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [view addSubview:yuELab];
    
    UIButton *allBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-52-8, yuELab.center.y-10, 52, 20) text:@"全部提现" font:[UIFont systemFontOfSize:12] textColor:@"#4A90E2" backgroundColor:@"" normal:@"" selected:nil];
    [view addSubview:allBtn];
    [allBtn addTarget:self action:@selector(allAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn = [UIButton buttonWithframe:CGRectMake(34, view.bottom+27, kScreenWidth-68, 42) text:@"确认提现" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    okBtn.layer.cornerRadius = 7;
    okBtn.layer.masksToBounds = YES;
    [self.view addSubview:okBtn];
    [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)allAction
{
    if (self.yuE.floatValue > 0) {
        _moneyTF.text = self.yuE;

    }
}

- (void)okAction
{
    if (_countTF.text.length == 0) {
        [self.view makeToast:@"请输入账号"];
        return;
    }
    
    if (_moneyTF.text.length == 0) {
        [self.view makeToast:@"请输入金额"];
        return;
    }
    
    [self takeCash];

    
}

// 4.6    提现
- (void)takeCash
{
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [paramDic setValue:_countTF.text forKey:@"takeAccount"];
    [paramDic setValue:_moneyTF.text forKey:@"Money"];
    [paramDic setValue:self.takeType forKey:@"takeType"];

    
    NSLog(@"paramDic:%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:TakeCash dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"1-3个工作日提现成功。" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //充值或提现成功通知事件
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kchargeOrDepositSuccessNotification" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        //    [okAction setValue:[UIColor colorWithHexString:@"#D0021B"] forKey:@"_titleTextColor"];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        

        
    } failure:^(NSError *error) {
        
    }];
}

- (void)payWayAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    self.lastBtn.selected = NO;
    btn.selected = YES;
    if (btn.tag == 0) {
        self.takeType = @"wxpay";
    }
    else {
        self.takeType = @"alipay";
        
    }
    self.lastBtn = btn;
}

@end
