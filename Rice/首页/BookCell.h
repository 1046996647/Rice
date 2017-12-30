//
//  BookCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"


@interface BookCell : UITableViewCell

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UIImageView *imgView2;
@property(nonatomic,strong) UIImageView *imgView3;
@property(nonatomic,strong) UILabel *weekLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UIButton *delBtn;
@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong) UIButton *xiaDanBtn;

@property(nonatomic,strong) FoodModel *model;


@end
