//
//  BalancePaymentDetailCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BalancePaymentDetailCell.h"
#import "NSStringExt.h"

@implementation BalancePaymentDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _contentLab = [UILabel labelWithframe:CGRectZero text:@"押金退回" font:SystemFont(15) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_contentLab];
        
        _timeLab = [UILabel labelWithframe:CGRectZero text:@"2017-10-23 18:45" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_timeLab];
        
        _moneyLab = [UILabel labelWithframe:CGRectZero text:@"+10.00元" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentRight textColor:@"#69D8D6"];
        [self.contentView addSubview:_moneyLab];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentLab.frame = CGRectMake(30, 12, 200, 21);
    _timeLab.frame = CGRectMake(_contentLab.left, _contentLab.bottom+3, 200, 17);
    
    CGSize size = [NSString textLength:_moneyLab.text font:_moneyLab.font];
    _moneyLab.frame = CGRectMake(self.width-size.width-14, 20, size.width, 25);
}

- (void)setModel:(PayRecordModel *)model
{
    _model = model;
    
    _contentLab.text = model.typeName;
    _timeLab.text = model.createTime;
    
    if (model.isAdd) {
        _moneyLab.text = [NSString stringWithFormat:@"+%@元",model.money];
        _moneyLab.textColor = [UIColor colorWithHexString:@"#69D8D6"];
    }
    else {
        _moneyLab.text = [NSString stringWithFormat:@"-%@元",model.money];
        _moneyLab.textColor = [UIColor colorWithHexString:@"#D0021B"];


    }


}







@end
