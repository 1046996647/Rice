//
//  BalancePaymentDetailCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayRecordModel.h"

@interface BalancePaymentDetailCell : UITableViewCell

@property(nonatomic,strong) UILabel *contentLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) PayRecordModel *model;

@end
