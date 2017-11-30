//
//  MarkVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^MarkBlock)(NSString *text);

@interface MarkVC : BaseViewController

@property(nonatomic,copy) MarkBlock block;
@property(nonatomic,strong) NSString *text;


@end
