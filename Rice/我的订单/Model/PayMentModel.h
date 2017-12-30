//
//  PayMentModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PriceAllModel, UserAddressModel, PayMentModel, FoodModel1;

// status：0未支付1待抢单2派送中 3已送达 5取消订单  7已评价 8待回收订单
@interface PayMentModel : NSObject


@property(nonatomic,strong) NSArray *listFoods;
@property(nonatomic,strong) PriceAllModel *priceAll;// 嵌套时字段必须对应
@property(nonatomic,strong) UserAddressModel *userAddress;
@property(nonatomic,strong) NSString *balance;
@property(nonatomic,strong) NSString *coupon;
@property(nonatomic,assign) BOOL isUseBalance;
@property(nonatomic,assign) BOOL isUseCoupon;
@property(nonatomic,assign) BOOL isActual;
@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *remarks;
@property(nonatomic,strong) NSString *sumPrice;
@property(nonatomic,strong) NSString *riderPhone;
@property(nonatomic,strong) NSString *riderName;
@property(nonatomic,strong) NSString *deposit;
@property(nonatomic,strong) NSString *timeArea;
@property(nonatomic,strong) NSString *arriveTime;

@property(nonatomic,assign) NSInteger restSeconds;



/// 倒计时源
@property (nonatomic, copy) NSString *countDownSource;

//@property (nonatomic, assign) NSInteger count;

@end

//
@interface FoodModel1 : NSObject

@property(nonatomic,strong) NSString *foodComment;
@property(nonatomic,strong) NSString *foodStars;


@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *foodId;
@property(nonatomic,strong) NSString *foodName;
@property(nonatomic,strong) NSString *foodImg;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *isMain;
@property(nonatomic,strong) NSString *foodPrice;


@end

@interface PriceAllModel : NSObject

@property(nonatomic,strong) NSString *payMoney;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *useBalance;
@property(nonatomic,strong) NSString *useCoupon;


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








