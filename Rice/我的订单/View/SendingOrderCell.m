//
//  SendingOrderCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SendingOrderCell.h"

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
        
        _countLab = [UILabel labelWithframe:CGRectMake(_imgView.right+28, 20, 17, 20) text:@"X1" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_countLab];
        
        
        _stateLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-72-20, 20, 72, 20) text:@"订单配送中" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
        [self.contentView addSubview:_stateLab];
        
        _evaluateBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-65-20, _stateLab.bottom+25, 65, 26) text:@"取消订单" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"Rectangle 14" selected:nil];
        _evaluateBtn.layer.cornerRadius = 5;
        _evaluateBtn.layer.masksToBounds = YES;
        _evaluateBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _evaluateBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_evaluateBtn];
        
        _payBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-65-20, _stateLab.bottom+25, 65, 26) text:@"确认付款" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"Rectangle 14" selected:nil];
        _payBtn.layer.cornerRadius = 5;
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _payBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_payBtn];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(_payBtn.left-10-100, _payBtn.center.y-10, 100, 20) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#D0021B"];
        [self.contentView addSubview:_timeLab];
        
        _confirmBtn = [UIButton buttonWithframe:CGRectMake(_evaluateBtn.left-10-_evaluateBtn.width, _evaluateBtn.top, _evaluateBtn.width, 26) text:@"催单" font:_stateLab.font textColor:@"#333333" backgroundColor:@"#FFE690" normal:@"Rectangle 14" selected:nil];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _confirmBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_confirmBtn];
        
        _moneyLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+26, _confirmBtn.left-_nameLab.left, 21) text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_moneyLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _moneyLab.bottom+17, kScreenWidth, .5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DDBA7F"];
        [self.contentView addSubview:_line];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
        //将定时器加入NSRunLoop，保证滑动表时，UI依然刷新
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    
    
    return self;
}

- (void)setModel:(PayMentModel *)model
{
    _model = model;
    
    FoodModel1 *foodModel = [model.listFoods firstObject];
    _nameLab.text = foodModel.foodName;
    _moneyLab.text = [NSString stringWithFormat:@"￥%@",foodModel.price];
     _countLab.text = [NSString stringWithFormat:@"X%@",foodModel.amount];
    
    
    if (model.status.integerValue == 0) {
        _stateLab.text = @"等待付款";
        _evaluateBtn.hidden = YES;
        _confirmBtn.hidden = YES;
        _payBtn.hidden = NO;
        _timeLab.hidden = NO;
        _timeLab.text = [self ll_timeWithSecond:model.restSeconds];

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

- (void)timerRun:(NSTimer *)timer {
    
    if (_model.status.integerValue == 0) {

        if (_model.restSeconds > 0) {
            _timeLab.text = [self ll_timeWithSecond:_model.restSeconds];
            _model.restSeconds -= 1;
        }
        else {
            if (_timer) {
                [_timer invalidate];
                _timer = nil;
            }
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

//重写父类方法，保证定时器被销毁
- (void)removeFromSuperview {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [super removeFromSuperview];
}

- (void)dealloc
{
    NSLog(@"cell释放");

}






@end
