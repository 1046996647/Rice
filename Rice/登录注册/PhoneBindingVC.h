//
//  PhoneBindingVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

@interface PhoneBindingVC : BaseViewController

@property(nonatomic,assign) NSInteger platformType;
@property (nonatomic, copy) NSString  *uid;
@property(nonatomic,strong) PersonModel *model;


@end
