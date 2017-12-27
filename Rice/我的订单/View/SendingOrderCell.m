//
//  SendingOrderCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SendingOrderCell.h"
#import "OYCountDownManager.h"

@implementation SendingOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLab = [UILabel labelWithframe:CGRectMake(20, 20, 72, 20) text:@"香辣鸡排饭" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(_nameLab.right+6, _nameLab.center.y-7, 24, 15) icon:@"特殊"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        _countLab = [UILabel labelWithframe:CGRectMake(_imgView.right+28, 20, 30, 20) text:@"X1" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_countLab];
        
        
        _stateLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-72-20, 20, 72, 20) text:@"订单配送中" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
        [self.contentView addSubview:_stateLab];
        
        _evaluateBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-65-20, _stateLab.bottom+25, 65, 26) text:@"取消订单" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"Rectangle 14" selected:nil];
        _evaluateBtn.layer.cornerRadius = 5;
        _evaluateBtn.layer.masksToBounds = YES;
        _evaluateBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _evaluateBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_evaluateBtn];
        [_evaluateBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        _payBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-65-20, _stateLab.bottom+25, 65, 26) text:@"确认付款" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"Rectangle 14" selected:nil];
        _payBtn.layer.cornerRadius = 5;
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _payBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_payBtn];
        _payBtn.userInteractionEnabled = NO;
        
        _timeLab = [UILabel labelWithframe:CGRectMake(_payBtn.left-10-100, _payBtn.center.y-10, 100, 20) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#D0021B"];
        [self.contentView addSubview:_timeLab];
        
        _confirmBtn = [UIButton buttonWithframe:CGRectMake(_evaluateBtn.left-10-_evaluateBtn.width, _evaluateBtn.top, _evaluateBtn.width, 26) text:@"催单" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"Rectangle 14" selected:nil];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _confirmBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_confirmBtn];
        [_confirmBtn addTarget:self action:@selector(cuiDanAction) forControlEvents:UIControlEventTouchUpInside];

        
        _moneyLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+26, _confirmBtn.left-_nameLab.left, 21) text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_moneyLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _moneyLab.bottom+17, kScreenWidth, .5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DDBA7F"];
        [self.contentView addSubview:_line];
        
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
        
    }
    
    
    return self;
}

- (void)cuiDanAction
{
    //    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.tele];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.riderPhone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}
- (void)cancelAction
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:self.model.orderId forKey:@"orderId"];
    [AFNetworking_RequestData requestMethodPOSTUrl:UserCancelOrder dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.viewController.view makeToast:@"取消成功"];
        if (self.block) {
            self.block(self.model);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)setModel:(PayMentModel *)model
{
    _model = model;
    
    FoodModel1 *foodModel = [model.listFoods firstObject];
    _nameLab.text = foodModel.foodName;
    _moneyLab.text = [NSString stringWithFormat:@"￥%@",model.sumPrice];
     _countLab.text = [NSString stringWithFormat:@"X%@",foodModel.amount];
    
    
    if (model.status.integerValue == 0) {
        _stateLab.text = @"等待付款";
        _evaluateBtn.hidden = YES;
        _confirmBtn.hidden = YES;
        _payBtn.hidden = NO;
        _timeLab.hidden = NO;
        _timeLab.text = [self ll_timeWithSecond:model.restSeconds];
        
        // 手动刷新数据
        [self countDownNotification];

    }
    else if (model.status.integerValue == 1) {
        _stateLab.text = @"等待配送中";
        _evaluateBtn.hidden = YES;
        _confirmBtn.hidden = YES;
        _payBtn.hidden = YES;
        _timeLab.hidden = YES;

    }
    else {
        _stateLab.text = @"订单配送中";
        _evaluateBtn.hidden = NO;
        _confirmBtn.hidden = NO;
        _payBtn.hidden = YES;
        _timeLab.hidden = YES;

    }
}

#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    
    if (_model.status.integerValue == 0) {
        
        NSInteger timeInterval;
        if (_model.countDownSource) {
            timeInterval = [kCountDownManager timeIntervalWithIdentifier:_model.countDownSource];
        }else {
            timeInterval = kCountDownManager.timeInterval;
        }
        NSInteger countDown = _model.restSeconds - timeInterval;
        
        if (countDown > 0) {
            _timeLab.text = [self ll_timeWithSecond:countDown];
        }
        else {

            if (self.block) {
                self.block(self.model);
            }
        }
    }
}


//将秒数转换为字符串格式
- (NSString *)ll_timeWithSecond:(NSInteger)second
{
    NSString *time;
    time = [NSString stringWithFormat:@"%02ld:%02ld",second/60,second%60];

    return time;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






@end
