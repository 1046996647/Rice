//
//  TYCyclePagerViewCell.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

typedef void(^TYCyclePagerViewBlock)(FoodModel *model,NSInteger tag);

@interface TYCyclePagerViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *bgView;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UIButton *delBtn;
@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong) FoodModel *model;
@property(nonatomic,copy) TYCyclePagerViewBlock block;


@end
