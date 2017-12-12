//
//  PayMentModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PriceAllModel, UserAddressModel, PayMentModel, FoodModel1;

// status：0未支付1待抢单2派送中
@interface PayMentModel : NSObject


@property(nonatomic,strong) NSArray *listFoods;
@property(nonatomic,strong) PriceAllModel *priceAll;// 嵌套时字段必须对应
@property(nonatomic,strong) UserAddressModel *userAddress;
@property(nonatomic,strong) NSString *balance;
@property(nonatomic,strong) NSString *coupon;
@property(nonatomic,strong) NSString *useBalance;
@property(nonatomic,strong) NSString *useCoupon;
@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,assign) NSInteger restSeconds;


@end

//
@interface FoodModel1 : NSObject

@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *foodId;
@property(nonatomic,strong) NSString *foodName;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *isMain;
@property(nonatomic,strong) NSString *price;


@end

@interface PriceAllModel : NSObject

@property(nonatomic,strong) NSString *payMoney;
@property(nonatomic,strong) NSString *price;



@end

//
@interface UserAddressModel : NSObject

@property(nonatomic,strong) NSString *leftTitle;
@property(nonatomic,strong) NSString *rightTitle;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *text;

@property(nonatomic,strong) NSString *lat;
@property(nonatomic,strong) NSString *lng;
@property(nonatomic,strong) NSString *addressId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *detail;
@property(nonatomic,strong) NSString *isRecently;

@end








