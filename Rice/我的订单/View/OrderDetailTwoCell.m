//
//  OrderDetailTwoCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OrderDetailTwoCell.h"


@implementation OrderDetailTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLab = [UILabel labelWithframe:CGRectZero text:@"可口可乐" font:[UIFont boldSystemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        
        _countLab = [UILabel labelWithframe:CGRectZero text:@"X1" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [self.contentView addSubview:_countLab];
        
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [self.contentView addSubview:_line];
        
    }
    
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _countLab.frame = CGRectMake(self.width-22-35, 14, 35, 20);
    _nameLab.frame = CGRectMake(21, 7, _countLab.left-21-10, 21);
    
    _line.frame = CGRectMake(22, self.height-1, self.width-44, 1);
    
}
@end
