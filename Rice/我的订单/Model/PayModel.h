//
//  PayModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModel : NSObject

// 微信
@property(nonatomic,strong) NSString *appid;
@property(nonatomic,strong) NSString *mch_id;
@property(nonatomic,strong) NSString *nonce_str;
@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) NSString *prepay_id;
@property(nonatomic,strong) NSString *sign;
@property(nonatomic,strong) NSString *timestamp;


// 支付宝
@property(nonatomic,strong) NSString *payStr;


@end
