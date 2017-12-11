//
//  UrlFile.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#ifndef UrlFile_h
#define UrlFile_h

// 服务器
//#define BaseUrl  @"http://192.168.2.21:61"

// 调试
#define BaseUrl  @"http://192.168.2.21:61"


// 注册
#define Register  [NSString stringWithFormat:@"%@/api/User/Register",BaseUrl]

// 短信登录
#define MailLogin  [NSString stringWithFormat:@"%@/api/User/Login",BaseUrl]

// 登录
#define Login  [NSString stringWithFormat:@"%@/api/User/Login",BaseUrl]


// 6.1    短信验证码
#define SendMail  [NSString stringWithFormat:@"%@/api/User/SendMail",BaseUrl]

// 1.6    忘记密码
#define FindPassword  [NSString stringWithFormat:@"%@/api/User/FindPassword",BaseUrl]

// 2.1    首页标签
#define GetTags  [NSString stringWithFormat:@"%@/api/HomePage/GetTags",BaseUrl]

// 2.2    首页菜品接口
#define GetFoods  [NSString stringWithFormat:@"%@/api/HomePage/GetFoods",BaseUrl]

// 2.5    保存首页点过的菜
#define SetTempFoods  [NSString stringWithFormat:@"%@/api/HomePage/SetTempFoods",BaseUrl]

// 2.2    订单生成
#define PlaceOrder  [NSString stringWithFormat:@"%@/api/Order/PlaceOrder",BaseUrl]

// 3.2    创建未支付订单
#define CreateOrder  [NSString stringWithFormat:@"%@/api/Order/CreateOrder",BaseUrl]

// 3.3    支付
#define PayOrder  [NSString stringWithFormat:@"%@/api/Order/PayOrder",BaseUrl]

// 2.3    首页配送中订单
#define GetSendingOrder  [NSString stringWithFormat:@"%@/api/HomePage/GetSendingOrder",BaseUrl]

// 设置用户个人信息
#define SetUserInfo  [NSString stringWithFormat:@"%@/api/user/SetUserInfo",BaseUrl]

// 4.1.2 用户新增地址
#define AddAddress  [NSString stringWithFormat:@"%@/api/UserAddress/AddAddress",BaseUrl]

// 用户更新地址
#define UpdateAddress  [NSString stringWithFormat:@"%@/api/UserAddress/UpdateAddress",BaseUrl]

// 用户删除地址
#define DeleteAddress  [NSString stringWithFormat:@"%@/api/UserAddress/DeleteAddress",BaseUrl]

// 获取用户所有的地址
#define GetAddress  [NSString stringWithFormat:@"%@/api/UserAddress/GetAddress",BaseUrl]

// 用户选择地址
#define ChooseAddress  [NSString stringWithFormat:@"%@/api/UserAddress/ChooseAddress",BaseUrl]


//// 1.7    验证旧手机验证码
//#define Check_phone  [NSString stringWithFormat:@"%@/User/check_phone",BaseUrl]
//
//// 1.8    确认修改手机
//#define Alter_phone  [NSString stringWithFormat:@"%@/User/alter_phone",BaseUrl]





// 1.16    上传头像
//#define Upload_company_logo  [NSString stringWithFormat:@"%@/User/upload_company_logo",BaseUrl]


#endif /* UrlFile_h */
