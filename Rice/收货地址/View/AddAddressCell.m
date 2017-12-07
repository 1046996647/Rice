//
//  AddAddressCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AddAddressCell.h"
#import "SearchAddressVC.h"

@implementation AddAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        self.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.textLabel.font = [UIFont systemFontOfSize:13];
        
        _tf = [UITextField textFieldWithframe:CGRectZero placeholder:nil font:nil leftView:nil backgroundColor:@"#FFFFFF"];
        _tf.font = [UIFont systemFontOfSize:13];
        [_tf setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        
        [self.contentView addSubview:_tf];
        [_tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIButton *saveBtn = [UIButton buttonWithframe:_tf.bounds text:nil font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
        [saveBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [_tf addSubview:saveBtn];
        self.saveBtn = saveBtn;
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [self.contentView addSubview:_line];
    }
    
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(21, self.height-1, self.width-21*2, 1);
    _tf.frame = CGRectMake(86, 0, self.width-86, 45);
    _saveBtn.frame = _tf.bounds;
}

- (void)pushAction
{
    SearchAddressVC *vc = [[SearchAddressVC alloc] init];
    vc.title = @"新增地址";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *text,NSString *lat,NSString *lng) {
        _model.text = text;
        _tf.text = text;
        _model.lat = lat;
        _model.lng = lng;
    };
}

- (void)setModel:(AddAddressModel *)model
{
    _model = model;
    
    self.textLabel.text = model.leftTitle;
    _tf.placeholder = model.rightTitle;
    _tf.text = model.text;
    
    if ([_model.leftTitle isEqualToString:@"  收货地址："]) {
        self.saveBtn.hidden = NO;
        [_tf setValue:[UIColor colorWithHexString:@"#8B572A"] forKeyPath:@"_placeholderLabel.textColor"];

    }
    else {
        self.saveBtn.hidden = YES;
        [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

    }
}
- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;
}

@end
