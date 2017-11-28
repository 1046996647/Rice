//
//  ReceiveAddressCell.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveAddressCell : UITableViewCell

//typedef void(^ReceiveAddressBlock)(ReleaseJobModel *model, NSInteger type);

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *phoneLab;
@property(nonatomic,strong) UILabel *addressLab;


@end
