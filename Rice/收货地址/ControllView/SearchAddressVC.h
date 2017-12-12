//
//  SearchAddressVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/5.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import <TencentLBS/TencentLBS.h>


typedef void(^SearchAddressBlock)(NSString *text,NSString *lat,NSString *lng);


@interface SearchAddressVC : BaseViewController

@property(nonatomic,copy) SearchAddressBlock block;
@property (nonatomic, strong) TencentLBSLocation *lBSLocation;


@end
