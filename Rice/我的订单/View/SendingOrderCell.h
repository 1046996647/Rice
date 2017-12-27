//
//  SendingOrderCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayMentModel.h"

typedef void(^SendingOrderBlock)(PayMentModel *model);


@interface SendingOrderCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *stateLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UIButton *confirmBtn;
@property(nonatomic,strong) UIButton *evaluateBtn;
@property(nonatomic,strong) UIButton *payBtn;
@property(nonatomic,strong) PayMentModel *model;
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,copy) SendingOrderBlock block;



@end
