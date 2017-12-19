//
//  LeftViewCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "LeftViewCell.h"
#import "Constants.h"

@implementation LeftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(34, 32, 23, 23) icon:@""];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;

        [self.contentView addSubview:_imgView];
        
        
        _leftLab = [UILabel labelWithframe:CGRectMake(_imgView.right+31, _imgView.top, 100, 17) text:@"" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_leftLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(_imgView.right+21, _leftLab.bottom+4, kLeftViewW-(_imgView.right+21), 1)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#8B572A"];
        [self.contentView addSubview:_line];
        
    }
    
    
    return self;
}

@end
