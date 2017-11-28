//
//  BookHeaderView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookHeaderView.h"

@interface BookHeaderView()

@property(nonatomic,strong) UILabel *addresLab;
@property(nonatomic,strong) UILabel *nameLab;
//@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIView *line;


@end

@implementation BookHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _addresLab = [UILabel labelWithframe:CGRectMake(21, 10, kScreenWidth-21-10, 20) text:@"浙江杭州余杭区赛银国际广场8幢802" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self addSubview:_addresLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _addresLab.bottom+7, kScreenWidth-21-10, 17) text:@"Dayday 18842682580" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self addSubview:_nameLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(22, _nameLab.bottom+10, self.width-44, 1)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [self addSubview:_line];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(_addresLab.left, _line.bottom+10, kScreenWidth-21-10, 17) text:@"9:00-9:30" font:SystemFont(12) textAlignment:NSTextAlignmentLeft textColor:@"#4A90E2"];
        [self addSubview:_timeLab];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(0, _timeLab.bottom+9, kScreenWidth, 17) icon:@"21"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];

        self.height = _imgView.bottom+11;
        
    }
    return self;
}

@end
