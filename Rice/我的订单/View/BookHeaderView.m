//
//  BookHeaderView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookHeaderView.h"
#import "UILabel+WLAttributedString.h"
#import "ReceiveAddressVC.h"
#import "BRPickerView.h"


@interface BookHeaderView()



@end

@implementation BookHeaderView

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
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(22, _nameLab.bottom+10, self.width-44, 1)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [self.baseView addSubview:_line];
        
        self.baseView.height = _line.bottom;
        
        // 9:00-9:30
        _timeLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, self.baseView.bottom+11, kScreenWidth-21-10, 17) text:@"请选择时间" font:SystemFont(12) textAlignment:NSTextAlignmentLeft textColor:@"#4A90E2"];
        [self addSubview:_timeLab];
        _timeLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeAction)];
        [_timeLab addGestureRecognizer:tap1];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(0, _timeLab.bottom+9, kScreenWidth, 17) icon:@"21"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];
        
        _moneyLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _imgView.bottom+3, kScreenWidth-21-10, 17) text:@"可回收餐具押金：￥10 (餐具回收后，押金自动退回到余额。)" font:SystemFont(12) textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self addSubview:_moneyLab];
        

        self.height = _moneyLab.bottom+10;
        
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

- (void)timeAction
{
    NSArray *times = @[@"8:00-8:30",@"8:30-9:00",@"9:00-9:30",@"9:30-10:00",@"10:00-10:30",@"10:30-11:00",@"11:00-11:30"];
    [BRStringPickerView showStringPickerWithTitle:nil dataSource:times defaultSelValue:times[0] isAutoSelect:NO resultBlock:^(id selectValue) {
        
        _timeLab.text = selectValue;

        if (self.block) {
            self.block(selectValue);
        }
    }];
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
    
    if (self.time.length > 0) {
        _timeLab.text = self.time;

    }
    
    if (self.payMentModel.deposit.floatValue > 0) {
        _moneyLab.text = [NSString stringWithFormat:@"可回收餐具押金：￥%@ (餐具回收后，押金自动退回到余额。)",self.payMentModel.deposit];
        [_moneyLab wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#D0021B"] changeText:@"(餐具回收后，押金自动退回到余额。)"];
    }
    else {
        _moneyLab.hidden = YES;
        
    }
    
    if (userAddressModel) {
        
        self.baseView.userInteractionEnabled = YES;
        
        _addBtn.hidden = YES;
        
        _addresLab.hidden = NO;
        _nameLab.hidden = NO;
        _addressImg.hidden = NO;
        
        _addresLab.text = [NSString stringWithFormat:@"%@%@",userAddressModel.address,userAddressModel.detail];
        _nameLab.text = [NSString stringWithFormat:@"%@ %@",userAddressModel.name,userAddressModel.phone];


    }
    else {
        
        self.baseView.userInteractionEnabled = NO;
        _addresLab.hidden = YES;
        _nameLab.hidden = YES;
        _addressImg.hidden = YES;
    }
}


@end
