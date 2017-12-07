//
//  TYCyclePagerViewCell.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@interface TYCyclePagerViewCell ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation TYCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
        _bgView = [UIImageView imgViewWithframe:CGRectZero icon:@"backView"];
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_bgView];

        _imgView = [UIImageView imgViewWithframe:CGRectZero icon:@""];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        
        
        _nameLab = [UILabel labelWithframe:CGRectZero text:@"剁椒鸡排饭" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        _moneyLab = [UILabel labelWithframe:CGRectZero text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [self.contentView addSubview:_moneyLab];
        
        _addBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"37" selected:nil];
        [self.contentView addSubview:_addBtn];
        _addBtn.tag = 0;
        [_addBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _countLab = [UILabel labelWithframe:CGRectZero text:@"0" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [self.contentView addSubview:_countLab];
        
        
        _delBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"38" selected:nil];
        [self.contentView addSubview:_delBtn];
        _delBtn.tag = 1;
        [_delBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];


    }
    return self;
}



- (void)layoutSubviews {
    
    [super layoutSubviews];

    _bgView.frame = self.bounds;

    
    _imgView.frame = CGRectMake(28, (138-120)/2, 120, 120);
    _imgView.layer.cornerRadius = _imgView.height/2;
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.borderColor = [UIColor colorWithHexString:@"#F8E249"].CGColor;
    _imgView.layer.borderWidth = 5;
//    _imgView.backgroundColor = [UIColor redColor];
    
    _nameLab.frame = CGRectMake(_imgView.right+10, 24, kScreenWidth-30-(_imgView.right+10)-32, 24);
    
    _moneyLab.frame = CGRectMake(_imgView.right+10, _nameLab.bottom+17, kScreenWidth-40-(_imgView.right+10)-32, 21);
    
    _addBtn.frame = CGRectMake(kScreenWidth-30-28-36, _moneyLab.bottom+14, 28, 28);
    
    _countLab.frame = CGRectMake(_addBtn.left-28, _moneyLab.bottom+14, 28, 28);
    
    _delBtn.frame = CGRectMake(_countLab.left-28, _moneyLab.bottom+14, 28, 28);

}

- (void)btnAction:(UIButton *)btn
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:self.model.foodId forKey:@"foodId"];
    
    if (btn.tag == 0) {
        [paraDic setValue:@"1" forKey:@"math"];
    }
    else {
        [paraDic setValue:@"-1" forKey:@"math"];

        if (_model.amount.integerValue == 0) {

            return;
        }
    }

    [AFNetworking_RequestData requestMethodPOSTUrl:SetTempFoods dic:paraDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSInteger amount = _model.amount.integerValue;
        if (btn.tag == 0) {
            _model.amount = [NSString stringWithFormat:@"%ld",(long)amount+1];
        }
        else {
            
            _model.amount = [NSString stringWithFormat:@"%ld",(long)amount-1];

            
        }
        _countLab.text = _model.amount;
        
        if (self.block) {
            self.block(_model, btn.tag);
        }

        
    } failure:^(NSError *error) {
        
        
    }];
    

}

- (void)setModel:(FoodModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.foodImg] placeholderImage:nil];
    _nameLab.text = model.foodName;
    _countLab.text = _model.amount;
    _moneyLab.text = [NSString stringWithFormat:@"￥%@",model.foodPrice];
}










@end
