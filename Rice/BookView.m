//
//  BookView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookView.h"
@interface BookView()

@property(nonatomic,strong) UIImageView *bgView;

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *remindLab;


@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UILabel *nameLab1;
@property(nonatomic,strong) UILabel *nameLab2;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *horsemanLab;
@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UIButton *evaBtn;
@property(nonatomic,strong) UILabel *kmLab;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *cuiDanBtn;
@property(nonatomic,strong) UIButton *maskBtn;
@property(nonatomic,strong) UIView *line1;
@property(nonatomic,strong) UIView *line2;

@end

@implementation BookView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [UIImageView imgViewWithframe:self.bounds icon:@"backView"];
//        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgView];
        
        // 没有订单---------------
        _imgView = [UIImageView imgViewWithframe:CGRectMake(self.width/2-108, 14, 108, 108) icon:@"31"];
//                _bgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];
        
        _remindLab = [UILabel labelWithframe:CGRectMake(_imgView.right+35, 0, 90, self.height) text:@"快点餐吧~" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self addSubview:_remindLab];
        
        // 有订单---------------
        _baseView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_baseView];
        _baseView.hidden = YES;
        
        // 骑手
        _horsemanLab = [UILabel labelWithframe:CGRectMake(self.width-100-13, 11, 100, 21) text:@"" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [_baseView addSubview:_horsemanLab];
        
        // 菜1
        _nameLab1 = [UILabel labelWithframe:CGRectMake(17, _horsemanLab.center.y-10, _horsemanLab.left-17-10, 21) text:@"" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_nameLab1];
        
        // 数量 179单
        _countLab = [UILabel labelWithframe:CGRectMake(self.width-45-13, _horsemanLab.bottom+4, 45, 18) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [_baseView addSubview:_countLab];
        
        // 评价
        _evaBtn = [UIButton buttonWithframe:CGRectMake(_countLab.left-45-5, _countLab.center.y-9, 45, 18) text:@"" font:SystemFont(13) textColor:@"#666666" backgroundColor:nil normal:@"Shape-1" selected:nil];
        _evaBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_baseView addSubview:_evaBtn];
        
        // 菜2
        _nameLab2 = [UILabel labelWithframe:CGRectMake(_nameLab1.left, _evaBtn.center.y-10, _evaBtn.left-17-10, 21) text:@"" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_nameLab2];
        
        // 距离 距您4.8km
        _kmLab = [UILabel labelWithframe:CGRectMake(self.width-68-13, _evaBtn.bottom+7, 68, 18) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#8B572A"];
        [_baseView addSubview:_kmLab];
        
        
        // 金额 ￥14.8
        _moneyLab = [UILabel labelWithframe:CGRectMake(_nameLab1.left, _kmLab.center.y-10, _evaBtn.left-17-10, 21) text:@"" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_moneyLab];
        
        // 横线
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(3, 90, self.width-6, 2)];
        _line1.backgroundColor = colorWithHexStr(@"#EDE1CE");
        [_baseView addSubview:_line1];
        
        // 取消
        _cancelBtn = [UIButton buttonWithframe:CGRectMake(0, _line1.bottom, self.width/2-2, 44) text:@"取消订单" font:SystemFont(15) textColor:@"#666666" backgroundColor:nil normal:@"取消" selected:nil];
        _cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_baseView addSubview:_cancelBtn];
        
        // 竖线
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(_cancelBtn.right, _cancelBtn.top, 2, _cancelBtn.height-6)];
        _line2.backgroundColor = colorWithHexStr(@"#EDE1CE");
        [_baseView addSubview:_line2];
        
        // 催单
        _cuiDanBtn = [UIButton buttonWithframe:CGRectMake(_line2.right, _cancelBtn.top, _cancelBtn.width, 44) text:@"催单" font:SystemFont(15) textColor:@"#666666" backgroundColor:nil normal:@"电话" selected:nil];
        _cuiDanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_baseView addSubview:_cuiDanBtn];
        
        // 蒙版
        _maskBtn = [UIButton buttonWithframe:CGRectMake(0, _cancelBtn.top, self.width, 44) text:@"" font:SystemFont(15) textColor:@"#666666" backgroundColor:nil normal:@"" selected:nil];
        [_baseView addSubview:_maskBtn];
        _maskBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        
//        self.height = _cuiDanBtn.bottom;
        
    }
    return self;
}


- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;

    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        _baseView.hidden = NO;
        _imgView.hidden = YES;
        _remindLab.hidden = YES;

        OrderModel *model = [OrderModel yy_modelWithJSON:dic];
        
        if (model.foodNames.count<2) {
            _nameLab2.hidden = YES;
            _moneyLab.top = _evaBtn.center.y-9;
            _nameLab1.text = model.foodNames[0];
        }
        else  {
            _nameLab1.text = model.foodNames[0];
            _nameLab2.text = model.foodNames[1];
            
        }
        
        if (model.status.integerValue == 1) {
            _kmLab.hidden = YES;
            _countLab.hidden = YES;
            _evaBtn.hidden = YES;
            _maskBtn.hidden = NO;
            
            _horsemanLab.text = [NSString stringWithFormat:@"等待骑手接单"];

        }
        else {
            _kmLab.hidden = NO;
            _countLab.hidden = NO;
            _evaBtn.hidden = NO;
            _maskBtn.hidden = YES;

            _horsemanLab.text = [NSString stringWithFormat:@"骑手 %@",model.riderName];

        }
        
        _moneyLab.text = [NSString stringWithFormat:@"￥%@",model.priceAll];

        
        _kmLab.text = [NSString stringWithFormat:@"距您%@km",model.distance];
        _countLab.text = [NSString stringWithFormat:@"%@单",model.sendCount];
        [_evaBtn setTitle:model.riderStars forState:UIControlStateNormal];
    }
    else {
        _baseView.hidden = YES;
        _imgView.hidden = NO;
        _remindLab.hidden = NO;
    }
    
    
}





@end
