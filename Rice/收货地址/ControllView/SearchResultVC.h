//
//  SearchResultVC.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/5.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import <TencentLBS/TencentLBS.h>
#import <QMapSearchKit/QMapSearchKit.h>


typedef void(^SearchResultBlock)(QMSPoiData *poiInfo);


@interface SearchResultVC : BaseViewController

@property (nonatomic, strong) TencentLBSLocation *lBSLocation;
@property (nonatomic, strong) NSString *city;
@property(nonatomic,copy) SearchResultBlock block;


@end
