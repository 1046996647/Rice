//
//  AddAddressModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddAddressModel : NSObject

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
