//
//  SettingVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SettingBlock)(void);


@interface SettingVC : BaseViewController

@property (nonatomic, copy) SettingBlock block;


@end
