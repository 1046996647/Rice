//
//  SystemMassageCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SystemMassageCell.h"

@implementation SystemMassageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];

        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(13, 16, kScreenWidth-26, 228)];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.cornerRadius = 10;
        baseView.layer.masksToBounds = YES;
        [self.contentView addSubview:baseView];

        // 个人APP新版上线
        _companyLab = [UILabel labelWithframe:CGRectMake(14, 10, baseView.width-28, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [baseView addSubview:_companyLab];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(_companyLab.left, _companyLab.bottom+9, _companyLab.width, 113) icon:@""];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [baseView addSubview:_imgView];
        
        // 个人新版上线
        _typeLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _imgView.bottom+13, _companyLab.width, 13) text:@"" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [baseView addSubview:_typeLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _typeLab.bottom+14, baseView.width, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [baseView addSubview:line];
        
        _peopleLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, line.bottom+9, _companyLab.width, _companyLab.height) text:@"立即查看" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [baseView addSubview:_peopleLab];
        
        
        UIImageView *jiantouImg = [UIImageView imgViewWithframe:CGRectMake(baseView.width-6-14, _peopleLab.center.y-7, 6, 13) icon:@"32"];
        jiantouImg.contentMode = UIViewContentModeScaleAspectFit;
        [baseView addSubview:jiantouImg];
        
        
    }
    return self;
}

- (void)setModel:(SystemModel *)model
{
    _companyLab.text = model.articleName;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.articleImg] placeholderImage:nil];
    _typeLab.text = model.content;

}

@end
