//
//  EvaluateVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^EvaluateBlock)(void);

@interface EvaluateVC : BaseViewController
@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,copy) EvaluateBlock block;


@end
