//
//  PersonalModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCoding>

// 自加
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *image;

/*
{
    "data": {
        "cname": "henglai",
        "title": "浙江恒来工贸有限公司",
        "email": "781183693@qq.com",
        "phone": "15260890523",
        "msgSend": "179", //剩余发送信息量
        "msgReceive": "180", //剩余接收信息量
        "resumeTotal": "3",
        "resumeMax": "3",
        "vipLevel": "2", //VIP等级  0 普通会员 1黄金会员 2 VIP会员
        "vipStart": "2015-07-21",
        "vipEnd": "2018-08-08",
        "resumeLeft": 0, //剩余简历浏览次数
        "vipTime": 1114,//剩余会员天数
        "viewResume": "5",//浏览简历次数
        "receiveResume": "5",//收到简历次数
        "favs": "1"//收藏人才数
    },
*/
@property(nonatomic,strong) NSString *cname;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString *img;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *msgSend;
@property(nonatomic,strong) NSString *msgReceive;
@property(nonatomic,strong) NSString *resumeTotal;
@property(nonatomic,strong) NSString *resumeMax;
@property(nonatomic,strong) NSString *receiveResume;
@property(nonatomic,strong) NSString *vipLevel;
@property(nonatomic,strong) NSString *vipStart;
@property(nonatomic,strong) NSString *vipEnd;
@property(nonatomic,strong) NSString *resumeLeft;
@property(nonatomic,strong) NSString *vipTime;
@property(nonatomic,strong) NSString *viewResume;
@property(nonatomic,strong) NSString *favs;

/*
"address": "浙江省缙云县洋山工业区四号地块",//公司地址
"type": "股份制",//公司性质
"logo": "http://106.14.212.85:8080/52dyjob/Public/Uploads/company/",
"lawer": "楼秀丰",//法人代表
"tele": "0578-3018196",//联系电话
"name": "马",//招聘负责人
"fax": "0578-3018185",//传真
"cateId": "26" //所属行业ID
*/

// 详情
@property(nonatomic,strong) NSString *info;
@property(nonatomic,strong) NSString *web;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *logo;
@property(nonatomic,strong) NSArray *jobs;

@property(nonatomic,strong) NSString *lawer;
@property(nonatomic,strong) NSString *tele;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *fax;
@property(nonatomic,strong) NSString *cateId;
@property(nonatomic,strong) NSString *cateName;

@property(nonatomic,assign) NSInteger cellHeight;

@end
