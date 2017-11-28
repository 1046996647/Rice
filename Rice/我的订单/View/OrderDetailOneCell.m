//
//  OrderDetailOneCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OrderDetailOneCell.h"

@implementation OrderDetailOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLab = [UILabel labelWithframe:CGRectZero text:@"香辣鸡排饭" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        
        _countLab = [UILabel labelWithframe:CGRectZero text:@"X1" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [self.contentView addSubview:_countLab];
        
        _moneyLab = [UILabel labelWithframe:CGRectZero text:@"￥14.8" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [self.contentView addSubview:_moneyLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithHexString:@"#FFFCEB"];
        [self.contentView addSubview:_line];
        
    }
    
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _moneyLab.frame = CGRectMake(self.width-53-23, 23, 53, 21);
    _countLab.frame = CGRectMake(_moneyLab.left-44-35, 22, 35, 21);
    _nameLab.frame = CGRectMake(21, 20, _countLab.left-21-10, 21);
    
    _line.frame = CGRectMake(0, self.height-5, self.width, 5);

}










@end
