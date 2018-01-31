//
//  MyBalletVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MyWalletVC.h"
#import "PayMentModel.h"
#import "BalancePaymentDetailVC.h"
#import "WithdrawDepositVC.h"
#import "RechargeVC.h"
#import "ScanVC.h"


@interface MyWalletVC ()

@property(nonatomic,strong) UIImageView *baseImg;
@property(nonatomic,strong) UIView *liJinView;
@property(nonatomic,strong) UIView *yuEView;
@property(nonatomic,strong) UITextField *maTF;


@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) PayMentModel *model;
@property(nonatomic,assign) NSInteger tag;



@end

@implementation MyWalletVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    baseView.backgroundColor = colorWithHexStr(@"#F8E249");
    [self.view addSubview:baseView];
    
    UILabel *label = [UILabel labelWithframe:CGRectMake(0, 20, kScreenWidth, 17) text:@"我的礼金券(元)" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [baseView addSubview:label];
    self.label = label;
    
    // 180.00
    UILabel *moneyLab = [UILabel labelWithframe:CGRectMake(0, label.bottom, kScreenWidth, 56) text:@"" font:[UIFont systemFontOfSize:40] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [baseView addSubview:moneyLab];
    self.moneyLab = moneyLab;

    UIImageView *baseImg = [UIImageView imgViewWithframe:CGRectMake((kScreenWidth-98)/2, moneyLab.bottom+31, 98, 32) icon:@"liJIn"];
    [baseView addSubview:baseImg];
    self.baseImg = baseImg;
    
    UIButton *liJinBtn = [UIButton buttonWithframe:CGRectMake(baseImg.left, baseImg.top, baseImg.width/2, baseImg.height) text:@"" font:SystemFont(16) textColor:@"#333333" backgroundColor:@"" normal:@"" selected:nil];
    [baseView addSubview:liJinBtn];
    liJinBtn.tag = 0;
    [liJinBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *yuEBtn = [UIButton buttonWithframe:CGRectMake(liJinBtn.right, baseImg.top, baseImg.width/2, baseImg.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"" selected:nil];
    [baseView addSubview:yuEBtn];
    yuEBtn.tag = 1;
    [yuEBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];

//    self.orderBtn = orderBtn;
    
    baseView.height = yuEBtn.bottom+20;
    
    //-----------礼金券------------
    UIView *liJinView = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.bottom, kScreenWidth, 0)];
    //    baseView.backgroundColor = colorWithHexStr(@"#F8E249");
    [self.view addSubview:liJinView];
    self.liJinView = liJinView;

    UIButton *duiHuanBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-106, 0, 106, 50) text:@"兑换" font:[UIFont systemFontOfSize:15] textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"" selected:nil];
    [liJinView addSubview:duiHuanBtn];
    [duiHuanBtn addTarget:self action:@selector(duiHuanAction) forControlEvents:UIControlEventTouchUpInside];


    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 43, duiHuanBtn.height)];
    UITextField *maTF = [UITextField textFieldWithframe:CGRectMake(0, duiHuanBtn.top, duiHuanBtn.left-2, duiHuanBtn.height) placeholder:@"请输入兑换码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    [liJinView addSubview:maTF];
    self.maTF = maTF;

    UIButton *saoBtn = [UIButton buttonWithframe:CGRectMake(0, maTF.bottom+2, kScreenWidth, duiHuanBtn.height) text:@"扫一扫" font:[UIFont systemFontOfSize:15] textColor:@"#666666" backgroundColor:@"#FFFFFF" normal:@"" selected:nil];
    [liJinView addSubview:saoBtn];
    [saoBtn addTarget:self action:@selector(saoAction) forControlEvents:UIControlEventTouchUpInside];

    liJinView.height = saoBtn.bottom;


    //-----------余额------------
    UIView *yuEView = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.bottom, kScreenWidth, 0)];
//    baseView.backgroundColor = colorWithHexStr(@"#F8E249");
    [self.view addSubview:yuEView];
    self.yuEView = yuEView;
    yuEView.hidden = YES;

    // 提现
    UIButton *tiXianBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreenWidth/2, 50) text:@"提现" font:[UIFont systemFontOfSize:15] textColor:@"#666666" backgroundColor:@"#FFFFFF" normal:@"" selected:nil];
    [yuEView addSubview:tiXianBtn];
    [tiXianBtn addTarget:self action:@selector(tiXianAction) forControlEvents:UIControlEventTouchUpInside];


    // 充值
    UIButton *chongZhiBtn = [UIButton buttonWithframe:CGRectMake(tiXianBtn.right, 0, kScreenWidth/2, 50) text:@"充值" font:[UIFont systemFontOfSize:15] textColor:@"#666666" backgroundColor:@"#FFFFFF" normal:@"" selected:nil];
    [yuEView addSubview:chongZhiBtn];
    [chongZhiBtn addTarget:self action:@selector(chongZhiAction) forControlEvents:UIControlEventTouchUpInside];


    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(tiXianBtn.width-.5, 10, .5, 30)];
    line.backgroundColor = colorWithHexStr(@"#E5E5E5");
    [tiXianBtn addSubview:line];

    yuEView.height = chongZhiBtn.bottom;


    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 67, 22) text:@"收支明细" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [viewBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
    
    [self getWallet];
    
    //充值或提现成功通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeOrDepositSuccess) name:@"kchargeOrDepositSuccessNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)duiHuanAction
{
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic setValue:self.maTF.text forKey:@"couponNo"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:ConvertCoupon dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.view makeToast:responseObject[@"message"]];
        [self getWallet];

        
    } failure:^(NSError *error) {
        
    }];
}

- (void)chargeOrDepositSuccess
{
    [self getWallet];

}

- (void)chongZhiAction
{
    RechargeVC *vc = [[RechargeVC alloc] init];
    vc.title = @"充值";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tiXianAction
{
    WithdrawDepositVC *vc = [[WithdrawDepositVC alloc] init];
    vc.title = @"提现";
    vc.yuE = self.model.balance;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnAction
{
    BalancePaymentDetailVC *vc = [[BalancePaymentDetailVC alloc] init];
    vc.title = @"收支明细";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getWallet
{
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetWallet dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        id obj = responseObject[@"data"];
        _model = [PayMentModel yy_modelWithJSON:obj];
        
        if (self.tag == 0) {
            self.moneyLab.text = _model.coupon;

        }
        else {
            self.moneyLab.text = _model.balance;

        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)saoAction
{
    ScanVC *vc = [[ScanVC alloc] init];
    vc.title = @"扫一扫";
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *str) {
        self.maTF.text = str;
    };
}

- (void)selectedAction:(UIButton *)btn
{
    self.tag = btn.tag;
    if (btn.tag == 0) {

        self.baseImg.image = [UIImage imageNamed:@"liJIn"];
        self.liJinView.hidden = NO;
        self.yuEView.hidden = YES;
        self.label.text = @"我的礼金券(元)";
        self.moneyLab.text = _model.coupon;

    }
    else {
        self.baseImg.image = [UIImage imageNamed:@"yuE"];
        self.liJinView.hidden = YES;
        self.yuEView.hidden = NO;
        self.label.text = @"我的余额(元)";
        self.moneyLab.text = _model.balance;


    }
}



@end
