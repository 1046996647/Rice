//
//  NearbyAddressCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/24.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyAddressCell.h"

@implementation NearbyAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _textLab = [UILabel labelWithframe:CGRectMake(28, 8, kScreenWidth-28, 17) text:nil font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_textLab];
        
        _detailLab = [UILabel labelWithframe:CGRectMake(_textLab.left, _textLab.bottom+5, _textLab.width, 14) text:nil font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [self.contentView addSubview:_detailLab];
        
        
    }
    return self;
}

@end
