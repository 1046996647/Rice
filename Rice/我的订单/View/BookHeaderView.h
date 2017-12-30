//
//  BookHeaderView.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PayMentModel.h"

typedef void(^BookHeaderViewBlock)(NSString *time);

@interface BookHeaderView : UIView

@property(nonatomic,strong) UIView *baseView;

@property(nonatomic,strong) UILabel *addresLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIImageView *addressImg;

@property(nonatomic,strong) UIButton *addBtn;

@property(nonatomic,strong) UserAddressModel *userAddressModel;
@property(nonatomic,strong) PayMentModel *payMentModel;

@property(nonatomic,strong) NSString *time;
@property(nonatomic,copy) BookHeaderViewBlock block;

@end
