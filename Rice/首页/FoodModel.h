//
//  FoodModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/1.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject

// 返回数据（isCycle是否可回收餐具、deposit押金金额，amount菜品总量）
@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *deposit;
@property(nonatomic,strong) NSString *foodId;
@property(nonatomic,strong) NSString *foodImg;
@property(nonatomic,strong) NSString *foodName;
@property(nonatomic,strong) NSString *foodPrice;
@property(nonatomic,strong) NSString *foodTagId;
@property(nonatomic,strong) NSString *secondTag;

@property(nonatomic,strong) NSString *isCycle;

@end
