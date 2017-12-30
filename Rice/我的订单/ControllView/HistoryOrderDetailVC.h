//
//  OrderDetailVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "PayMentModel.h"

typedef void(^HistoryOrderDetailBlock)(void);


@interface HistoryOrderDetailVC : BaseViewController

//@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,copy) HistoryOrderDetailBlock block;
@property(nonatomic,strong) PayMentModel *payMentModel1;


@end
