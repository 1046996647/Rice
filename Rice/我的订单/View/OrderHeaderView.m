//
//  OrderHeaderView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OrderHeaderView.h"
#import "UILabel+WLAttributedString.h"


@interface OrderHeaderView()

@property(nonatomic,strong) UILabel *addresLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *moneyLab;
//@property(nonatomic,strong) UILabel *stateLab;
@property(nonatomic,strong) UIImageView *imgView;


@end

@implementation OrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _addresLab = [UILabel labelWithframe:CGRectMake(21, 10, kScreenWidth-21-10, 20) text:@"浙江杭州余杭区赛银国际广场8幢802" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self addSubview:_addresLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _addresLab.bottom+7, kScreenWidth-21-10, 17) text:@"Dayday 18842682580" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self addSubview:_nameLab];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(0, _nameLab.bottom+8, kScreenWidth, 17) icon:@"21"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];

        _moneyLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _imgView.bottom, kScreenWidth-21-10, 17) text:@"可回收餐具押金：￥10 （押金已退回）" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self addSubview:_moneyLab];
        
        [_moneyLab wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:@"（押金已退回）"];

        
        self.height = _moneyLab.bottom+4;
        
    }
    return self;
}

@end
