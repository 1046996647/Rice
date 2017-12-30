//
//  HistoryOrderCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HistoryOrderCell.h"
#import "EvaluateVC.h"

@implementation HistoryOrderCell

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
        

        _stateLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-102-20, 20, 102, 20) text:@"订单已完成" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [self.contentView addSubview:_stateLab];
        
        _evaluateBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-65-20, _stateLab.bottom+25, 65, 26) text:@"评价" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"" selected:nil];
        _evaluateBtn.layer.cornerRadius = 5;
        _evaluateBtn.layer.masksToBounds = YES;
        _evaluateBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _evaluateBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_evaluateBtn];
        [_evaluateBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        _confirmBtn = [UIButton buttonWithframe:CGRectMake(_evaluateBtn.left-10-_evaluateBtn.width, _evaluateBtn.top, _evaluateBtn.width, 26) text:@"餐盒确认" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"" selected:nil];
//        _confirmBtn.layer.cornerRadius = 5;
//        _confirmBtn.layer.masksToBounds = YES;
//        _confirmBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
//        _confirmBtn.layer.borderWidth = 1;
//        [self.contentView addSubview:_confirmBtn];
        
        _moneyLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+26, _evaluateBtn.left-_nameLab.left, 21) text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_moneyLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _moneyLab.bottom+17, kScreenWidth, .5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DDBA7F"];
        [self.contentView addSubview:_line];
        
    }
    
    
    return self;
}

- (void)evaluateAction:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"评价"]) {
        EvaluateVC *vc = [[EvaluateVC alloc] init];
        vc.title = btn.currentTitle;
        vc.orderId = _model.orderId;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        vc.block = ^{
            _model.status = @"7";
        };
    }
    else {
        
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:self.model.orderId forKey:@"orderId"];
        [AFNetworking_RequestData requestMethodPOSTUrl:RequestRecovery dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            _model.status = @"9";
            [self.viewController.view makeToast:@"已发送回收通知"];
            if (self.block) {
                self.block();
            }
            
        } failure:^(NSError *error) {
            
            
        }];
    }

}
- (void)setModel:(PayMentModel *)model
{
    _model = model;
    
    FoodModel1 *foodModel = [model.listFoods firstObject];
    _nameLab.text = foodModel.foodName;
    _moneyLab.text = [NSString stringWithFormat:@"￥%@",model.sumPrice];
    _countLab.text = [NSString stringWithFormat:@"X%@",foodModel.amount];
    
    // 3已送达 5取消订单  7已评价
    if (model.status.integerValue == 3 ||
        model.status.integerValue == 7) {
        _stateLab.text = @"订单已完成";
        
        if (model.status.integerValue == 7) {
            _evaluateBtn.hidden = YES;

        }
        else {
            _evaluateBtn.hidden = NO;

        }
        
    }
    else if (model.status.integerValue == 5) {
        _stateLab.text = @"订单已取消";
        _evaluateBtn.hidden = YES;
        
    }
    else if (model.status.integerValue == 8)  {
        _stateLab.text = @"餐具待回收";
        
        _evaluateBtn.hidden = NO;
        [_evaluateBtn setTitle:@"通知回收" forState:UIControlStateNormal];
      
    }
    else if (model.status.integerValue == 9)  {
        _stateLab.text = @"已发送回收请求";
        _evaluateBtn.hidden = YES;

    }
}

@end
