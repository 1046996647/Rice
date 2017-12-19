//
//  RiderModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

// （riderType:0电瓶车1汽车）
@interface RiderModel : NSObject

@property(nonatomic,strong) NSString *riderId;
@property(nonatomic,strong) NSString *riderType;
@property(nonatomic,strong) NSString *lat;
@property(nonatomic,strong) NSString *lng;


@end
