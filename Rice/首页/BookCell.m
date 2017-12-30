//
//  BookCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookCell.h"
#import "BookPaymentOrderVC.h"
#import "LoginVC.h"

@implementation BookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //244
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.borderColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
        _bgView.layer.borderWidth = .5;
        [self.contentView addSubview:_bgView];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        _imgView1 = [UIImageView imgViewWithframe:CGRectZero icon:@""];
        _imgView1.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_imgView1];
//        _imgView1.backgroundColor = [UIColor redColor];
        
        _imgView2 = [UIImageView imgViewWithframe:CGRectZero icon:@"Rectangle 5"];
        _imgView2.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_imgView2];
        
        
        _imgView3 = [UIImageView imgViewWithframe:CGRectZero icon:@"Rectangle"];
        _imgView3.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_imgView3];
        
        _weekLab = [UILabel labelWithframe:CGRectZero text:@"周一\n午餐" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#8B572A"];
        [_imgView2 addSubview:_weekLab];
        _weekLab.numberOfLines = 0;
        
        _nameLab = [UILabel labelWithframe:CGRectZero text:@"剁椒鸡排饭" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
        [_imgView3 addSubview:_nameLab];
        
        _xiaDanBtn = [UIButton buttonWithframe:CGRectZero text:@"下单" font:[UIFont systemFontOfSize:19] textColor:@"#4A4A4A" backgroundColor:@"#F8E249" normal:@"" selected:nil];
        [_bgView addSubview:_xiaDanBtn];
        _xiaDanBtn.tag = 0;
        [_xiaDanBtn addTarget:self action:@selector(xiaDanAction) forControlEvents:UIControlEventTouchUpInside];
        _xiaDanBtn.layer.cornerRadius = 7;
        _xiaDanBtn.layer.masksToBounds = YES;
        
        _moneyLab = [UILabel labelWithframe:CGRectZero text:@"￥14.8" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_bgView addSubview:_moneyLab];
        
        _addBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"37" selected:nil];
        [_bgView addSubview:_addBtn];
        _addBtn.tag = 0;
        [_addBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _countLab = [UILabel labelWithframe:CGRectZero text:@"0" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [_bgView addSubview:_countLab];
        
        
        _delBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"38" selected:nil];
        [_bgView addSubview:_delBtn];
        _delBtn.tag = 1;
        [_delBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)xiaDanAction
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        vc.level = 1;
        [self.viewController.navigationController pushViewController:vc animated:YES];

        return;
    }
    
    if (_model.amount.integerValue == 0) {
        [self.viewController.view makeToast:@"请添加菜品"];
        return;
    }
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic  setValue:_model.foodId forKey:@"foodId"];
    [paramDic  setValue:_model.amount forKey:@"amount"];
    
    BookPaymentOrderVC *vc = [[BookPaymentOrderVC alloc] init];
    vc.title = @"预定支付订单";
    vc.param = paramDic;
//    vc.mark = 1;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)btnAction:(UIButton *)btn
{
    
    NSInteger amount = _model.amount.integerValue;
    if (btn.tag == 0) {
        _model.amount = [NSString stringWithFormat:@"%ld",(long)amount+1];
    }
    else {
        
        _model.amount = [NSString stringWithFormat:@"%ld",(long)amount-1];
        
        
    }
    _countLab.text = _model.amount;
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _bgView.frame = CGRectMake(15, 11, self.width-30, 233);
    
    _imgView1.frame = CGRectMake(0, 0, _bgView.width, 194);
    _imgView2.frame = CGRectMake(23, 0, 58, 58);
    _imgView3.frame = CGRectMake(_bgView.width-105, 0, 105, 31);

    _weekLab.frame = _imgView2.bounds;
    _weekLab.top = -3;
    
    _nameLab.frame = CGRectMake(5, 0, _imgView3.width-10, _imgView3.height);
    

    _xiaDanBtn.frame = CGRectMake(_bgView.width-67-12, _imgView1.bottom+5, 67, 29);

    _moneyLab.frame = CGRectMake(14, _xiaDanBtn.center.y-11, 100, 22);

    _countLab.frame = CGRectMake((_bgView.width-28)/2, _xiaDanBtn.center.y-14, 28, 28);

    _addBtn.frame = CGRectMake(_countLab.right, _countLab.top, 28, 28);
    
    
    _delBtn.frame = CGRectMake(_countLab.left-28, _countLab.top, 28, 28);
    
}

- (void)setModel:(FoodModel *)model
{
    _model = model;
    
    
    model.amount = @"0";
    
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.foodImg] placeholderImage:nil];
    
    NSMutableString *str = model.secondTag.mutableCopy;
    [str insertString:@"\n" atIndex:2];
    _weekLab.text = str;
    
    _nameLab.text = model.foodName;
    
    _moneyLab.text = [NSString stringWithFormat:@"￥%@",model.foodPrice];

    _countLab.text = model.amount;

}




@end
