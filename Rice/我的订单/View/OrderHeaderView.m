//
//  OrderHeaderView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OrderHeaderView.h"
#import "ReceiveAddressVC.h"
#import "UILabel+WLAttributedString.h"


@interface OrderHeaderView()


@end

@implementation OrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.baseView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.baseView];

        
        _addressImg = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-13-10, 16, 13, 21) icon:@"11"];
        [self.baseView addSubview:_addressImg];
        
        _addresLab = [UILabel labelWithframe:CGRectMake(21, 10, kScreenWidth-21-10, 20) text:@"浙江杭州余杭区赛银国际广场8幢802" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.baseView addSubview:_addresLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _addresLab.bottom+7, kScreenWidth-21-10, 17) text:@"Dayday 18842682580" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.baseView addSubview:_nameLab];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(0, _nameLab.bottom+8, kScreenWidth, 17) icon:@"21"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.baseView addSubview:_imgView];

        _moneyLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _imgView.bottom, kScreenWidth-21-10, 17) text:@"可回收餐具押金：￥10 （押金已退回）" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.baseView addSubview:_moneyLab];
        
        [_moneyLab wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:@"（押金已退回）"];

        
        self.baseView.height = _moneyLab.bottom+4;
        self.height = self.baseView.height;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAction)];
        [self.baseView addGestureRecognizer:tap];
        
        // 添加地址
        _addBtn = [UIButton buttonWithframe:CGRectMake(13, 14, kScreenWidth-26, 35) text:@"请添加地址" font:SystemFont(14) textColor:@"#333333" backgroundColor:nil normal:@"ic_plus" selected:nil];
        _addBtn.layer.cornerRadius = 5;
        _addBtn.layer.masksToBounds = YES;
        _addBtn.layer.borderColor = [UIColor colorWithHexString:@"#FCDF5B"].CGColor;
        _addBtn.layer.borderWidth = 1;
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12);
        [self addSubview:_addBtn];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (void)addAction
{
    ReceiveAddressVC *vc = [[ReceiveAddressVC alloc] init];
    vc.title = @"收货地址";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    vc.block = ^(UserAddressModel *model) {

        self.userAddressModel = model;

    };
}

- (void)setUserAddressModel:(UserAddressModel *)userAddressModel
{
    _userAddressModel = userAddressModel;
    
    if (userAddressModel) {
        
        self.baseView.userInteractionEnabled = YES;

        _addBtn.hidden = YES;
        _moneyLab.hidden = YES;
        
        _addresLab.hidden = NO;
        _nameLab.hidden = NO;
        _addressImg.hidden = NO;
        
        _addresLab.text = [NSString stringWithFormat:@"%@%@",userAddressModel.address,userAddressModel.detail];
        _nameLab.text = [NSString stringWithFormat:@"%@ %@",userAddressModel.name,userAddressModel.phone];
        

    }
    else {
        
        self.baseView.userInteractionEnabled = NO;
        _moneyLab.hidden = YES;
        _addresLab.hidden = YES;
        _nameLab.hidden = YES;
        _addressImg.hidden = YES;
    }
}

@end
