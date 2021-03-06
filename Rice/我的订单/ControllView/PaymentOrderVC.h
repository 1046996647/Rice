//
//  PaymentOrderVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PaymentOrderBlock)(void);

@interface PaymentOrderVC : BaseViewController

@property(nonatomic,strong) NSMutableDictionary *param;
@property(nonatomic,copy) PaymentOrderBlock block;


@end
