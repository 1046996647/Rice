//
//  LoginVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^LoginBlock)(void);

@interface LoginVC : BaseViewController

@property(nonatomic,copy) LoginBlock block;


@end
