//
//  OrderModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/1.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic,strong) NSArray *foodNames;
@property(nonatomic,strong) NSString *priceAll;
@property(nonatomic,strong) NSString *riderName;
@property(nonatomic,strong) NSString *riderPhone;
@property(nonatomic,strong) NSString *riderStars;
@property(nonatomic,strong) NSString *sendCount;
@property(nonatomic,strong) NSString *distance;

@end
