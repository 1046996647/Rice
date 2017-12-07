//
//  ReceiveAddressCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAddressModel.h"

typedef void(^ReceiveAddressBlock)(void);

@interface ReceiveAddressCell : UITableViewCell



@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *phoneLab;
@property(nonatomic,strong) UILabel *addressLab;
@property(nonatomic,strong) AddAddressModel *model;
@property(nonatomic,copy) ReceiveAddressBlock block;


@end
