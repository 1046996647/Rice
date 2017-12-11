//
//  PayMentModel.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PayMentModel.h"

//
@implementation PriceAllModel

@end

//
@implementation UserAddressModel

@end

@implementation PayMentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"listFoods": [FoodModel1 class]
             };
}

@end

//
@implementation FoodModel1

@end
