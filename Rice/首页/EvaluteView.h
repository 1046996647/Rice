//
//  EvaluteView.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EvaluteViewBlock)(NSString *orderId);


@interface EvaluteView : UIView

@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,copy) EvaluteViewBlock block;


@end
