//
//  OrderDetailTwoCell1.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OrderDetailTwoCell1.h"

@implementation OrderDetailTwoCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLab = [UILabel labelWithframe:CGRectZero text:@"可口可乐" font:[UIFont boldSystemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        
        _addBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"37" selected:nil];
        [self.contentView addSubview:_addBtn];
        
        _countLab = [UILabel labelWithframe:CGRectZero text:@"0" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [self.contentView addSubview:_countLab];
        
        
        _delBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"38" selected:nil];
        [self.contentView addSubview:_delBtn];
        
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [self.contentView addSubview:_line];
        
    }
    
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _addBtn.frame = CGRectMake(kScreenWidth-16-22, 8, 22, 22);
    
    _countLab.frame = CGRectMake(_addBtn.left-28, _addBtn.top, 28, 28);
    
    _delBtn.frame = CGRectMake(_countLab.left-28, _addBtn.top, 22, 22);
    
    _nameLab.frame = CGRectMake(21, 7, _countLab.left-21-10, 21);
    
    _line.frame = CGRectMake(22, self.height-1, self.width-44, 1);
    
}

@end
