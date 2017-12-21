//
//  PersonalModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCoding>

//// 自加
//@property(nonatomic,strong) NSString *title;
//@property(nonatomic,strong) NSString *key;
//@property(nonatomic,strong) NSString *text;
//@property(nonatomic,strong) NSString *image;


@property(nonatomic,strong) NSString *Token;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *balance;
@property(nonatomic,strong) NSString *wechat;
@property(nonatomic,strong) NSString *qq;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *headImg;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *coupon;
@property(nonatomic,assign) BOOL hasPwd;




@property(nonatomic,assign) NSInteger cellHeight;

@end
