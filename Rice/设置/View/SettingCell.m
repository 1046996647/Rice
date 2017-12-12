//
//  SettingCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
        _imgView = [UIImageView imgViewWithframe:CGRectZero icon:@"Back Chevron Copy 2"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [self.contentView addSubview:_line];
    }
    
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(self.width-9-12, 0, 9, self.height);
    _line.frame = CGRectMake(21, self.height-1, self.width-21*2, 1);
    
    

}

- (void)dealloc {
    NSLog(@"---------cell释放");
}

@end
