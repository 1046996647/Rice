//
//  SystemMassageCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemModel.h"

@interface SystemMassageCell : UITableViewCell

@property(nonatomic,strong) UILabel *typeLab;
@property(nonatomic,strong) UILabel *companyLab;
@property(nonatomic,strong) UILabel *peopleLab;
//@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) SystemModel *model;

@end
