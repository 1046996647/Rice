//
//  OrderDetailTwoCell1.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayMentModel.h"

typedef void(^OrderDetailTwoBlock)(FoodModel1 *model);

@interface OrderDetailTwoCell1 : UITableViewCell

@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UIButton *delBtn;
@property(nonatomic,strong) UIButton *addBtn;

@property(nonatomic,strong) FoodModel1 *model;
@property(nonatomic,copy) OrderDetailTwoBlock block;


@end
