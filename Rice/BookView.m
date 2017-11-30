//
//  BookView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookView.h"
@interface BookView()

//@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *bgView;
@property(nonatomic,strong) UILabel *nameLab1;
@property(nonatomic,strong) UILabel *nameLab2;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *horsemanLab;
@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UIButton *evaBtn;
@property(nonatomic,strong) UILabel *kmLab;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *cuiDanBtn;
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
        
        // 骑手
        _horsemanLab = [UILabel labelWithframe:CGRectMake(self.width-90-13, 11, 90, 21) text:@"骑手 陈大明" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [self addSubview:_horsemanLab];
        
        // 菜1
        _nameLab1 = [UILabel labelWithframe:CGRectMake(17, _horsemanLab.center.y-10, _horsemanLab.left-17-10, 21) text:@"剁椒鸡排饭" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self addSubview:_nameLab1];
        
        // 数量
        _countLab = [UILabel labelWithframe:CGRectMake(self.width-45-13, _horsemanLab.bottom+4, 45, 18) text:@"179单" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [self addSubview:_countLab];
        
        // 评价
        _evaBtn = [UIButton buttonWithframe:CGRectMake(_countLab.left-45-5, _countLab.center.y-9, 45, 18) text:@"5.0" font:SystemFont(13) textColor:@"#666666" backgroundColor:nil normal:@"Shape-1" selected:nil];
        _evaBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self addSubview:_evaBtn];
        
        // 菜2
        _nameLab2 = [UILabel labelWithframe:CGRectMake(_nameLab1.left, _evaBtn.center.y-10, _evaBtn.left-17-10, 21) text:@"香辣鸡排饭" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self addSubview:_nameLab2];
        
        // 距离
        _kmLab = [UILabel labelWithframe:CGRectMake(self.width-68-13, _evaBtn.bottom+7, 68, 18) text:@"距您4.8km" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#8B572A"];
        [self addSubview:_kmLab];
        
        
        // 金额
        _moneyLab = [UILabel labelWithframe:CGRectMake(_nameLab1.left, _kmLab.center.y-10, _evaBtn.left-17-10, 21) text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self addSubview:_moneyLab];
        
        // 横线
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(3, 90, self.width-6, 2)];
        _line1.backgroundColor = colorWithHexStr(@"#EDE1CE");
        [self addSubview:_line1];
        
        // 取消
        _cancelBtn = [UIButton buttonWithframe:CGRectMake(0, _line1.bottom, self.width/2-2, 44) text:@"取消订单" font:SystemFont(15) textColor:@"#666666" backgroundColor:nil normal:@"取消" selected:nil];
        _cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [self addSubview:_cancelBtn];
        
        // 竖线
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(_cancelBtn.right, _cancelBtn.top, 2, _cancelBtn.height)];
        _line2.backgroundColor = colorWithHexStr(@"#EDE1CE");
        [self addSubview:_line2];
        
        // 催单
        _cuiDanBtn = [UIButton buttonWithframe:CGRectMake(_line2.right, _cancelBtn.top, _cancelBtn.width, 44) text:@"催单" font:SystemFont(15) textColor:@"#666666" backgroundColor:nil normal:@"电话" selected:nil];
        _cuiDanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [self addSubview:_cuiDanBtn];
        
//        self.height = _cuiDanBtn.bottom;
        
    }
    return self;
}

@end
