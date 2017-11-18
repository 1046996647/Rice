//
//  BookOrderCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookOrderCell.h"

@implementation BookOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLab = [UILabel labelWithframe:CGRectMake(20, 20, 72, 20) text:@"香辣鸡排饭" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(_nameLab.right+6, _nameLab.center.y-7, 24, 15) icon:@"特殊"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        _countLab = [UILabel labelWithframe:CGRectMake(_imgView.right+28, 20, 17, 20) text:@"X1" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_countLab];
        
        
        _stateLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-72-20, 20, 72, 20) text:@"等待配送中" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#8B572A"];
        [self.contentView addSubview:_stateLab];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-135-13, _nameLab.bottom+22, 135, 35) text:@"预定时间：2017-11-15\n9:30-10:00" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [self.contentView addSubview:_timeLab];
        _timeLab.numberOfLines = 0;
        
        _moneyLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+26, _timeLab.left-_nameLab.left, 21) text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_moneyLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _moneyLab.bottom+17, kScreenWidth, .5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DDBA7F"];
        [self.contentView addSubview:_line];
        
    }
    
    
    return self;
}

@end
