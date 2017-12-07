//
//  ReceiveAddressCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReceiveAddressCell.h"

@implementation ReceiveAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _selectBtn = [UIButton buttonWithframe:CGRectZero text:@"" font:nil textColor:nil backgroundColor:nil normal:@"Oval 4" selected:@"选中的勾"];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        
        _nameLab = [UILabel labelWithframe:CGRectZero text:@"Dayday" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_nameLab];
        
        _phoneLab = [UILabel labelWithframe:CGRectZero text:@"18842682580" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_phoneLab];

        _addressLab = [UILabel labelWithframe:CGRectZero text:@"浙江杭州余杭区赛银国际广场8幢802" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_addressLab];
    }
    return self;
}

- (void)selectAction
{
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [paramDic setValue:self.model.addressId forKey:@"addressId"];

    [AFNetworking_RequestData requestMethodPOSTUrl:ChooseAddress dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        if (self.block) {
            self.block();
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _selectBtn.frame = CGRectMake(0, 0, 44, self.height);
    _phoneLab.frame = CGRectMake(self.width-94-11, 10, 94, 20);
    _nameLab.frame = CGRectMake(_selectBtn.right, 10, _phoneLab.left-(_selectBtn.right)-10, 24);
    _addressLab.frame = CGRectMake(_selectBtn.right, _nameLab.bottom+ 10, self.width-(_selectBtn.right)-10, 20);


}

- (void)setModel:(AddAddressModel *)model
{
    _model = model;
    
    _nameLab.text = model.name;
    _phoneLab.text = model.phone;
    _addressLab.text = [NSString stringWithFormat:@"%@%@",model.address,model.detail];
    _selectBtn.selected = model.isRecently.boolValue;
}



@end
