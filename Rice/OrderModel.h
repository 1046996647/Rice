//
//  OrderModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/1.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 获取进行中中的订单（status ：1待接单  2配送中）
@interface OrderModel : NSObject

@property(nonatomic,strong) NSArray *foodNames;
@property(nonatomic,strong) NSString *priceAll;
@property(nonatomic,strong) NSString *riderName;
@property(nonatomic,strong) NSString *riderPhone;
@property(nonatomic,strong) NSString *riderStars;
@property(nonatomic,strong) NSString *sendCount;
@property(nonatomic,strong) NSString *distance;
@property(nonatomic,strong) NSString *status;

@end
