//
//  EvaluateCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartsView.h"
#import "PayMentModel.h"


@interface EvaluateCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong) UIImageView *foodImg;
@property(nonatomic,strong) UILabel *foodName;
@property(nonatomic,strong) UILabel *foodEva;
@property(nonatomic,strong) UILabel *foodRemind;
@property(nonatomic,strong) UITextView *foodTV;
@property(nonatomic,strong) StartsView *foodStar;
@property(nonatomic,strong) FoodModel1 *model;

@end
