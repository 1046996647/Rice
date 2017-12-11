//
//  AddAddressCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayMentModel.h"


@interface AddAddressCell : UITableViewCell

@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIButton *saveBtn;

@property(nonatomic,strong) UserAddressModel *model;


@end
