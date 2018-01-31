//
//  UrlFile.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#ifndef UrlFile_h
#define UrlFile_h

// 服务器(推送要用服务器ip)
//#define BaseUrl  @"http://106.14.218.31:61"
#define BaseUrl  @"http://39.104.59.101:8061"

// 调试
//#define BaseUrl  @"http://192.168.2.21:61"


// 注册
#define Register  [NSString stringWithFormat:@"%@/api/User/Register",BaseUrl]

// 短信登录
#define MailLogin  [NSString stringWithFormat:@"%@/api/User/Login",BaseUrl]

// 登录
#define Login  [NSString stringWithFormat:@"%@/api/User/Login",BaseUrl]

// 1.4    设置登录密码
#define SetPassword  [NSString stringWithFormat:@"%@/api/User/SetPassword",BaseUrl]

// 第三方登录绑定手机号
#define BindPhone  [NSString stringWithFormat:@"%@/api/User/BindPhone",BaseUrl]

// 账号解绑
#define RemoveContact  [NSString stringWithFormat:@"%@/api/User/RemoveContact",BaseUrl]

// 绑定账号
#define BuildContact  [NSString stringWithFormat:@"%@/api/User/BuildContact",BaseUrl]


// 6.1    短信验证码
#define SendMail  [NSString stringWithFormat:@"%@/api/User/SendMail",BaseUrl]

// 1.6    忘记密码
#define FindPassword  [NSString stringWithFormat:@"%@/api/User/FindPassword",BaseUrl]

// 1.4    修改密码
#define ReSetPwd  [NSString stringWithFormat:@"%@/api/User/ReSetPwd",BaseUrl]

// 2.1    首页标签
#define GetTags  [NSString stringWithFormat:@"%@/api/HomePage/GetTags",BaseUrl]

// 2.2    首页菜品接口
#define GetFoods  [NSString stringWithFormat:@"%@/api/HomePage/GetFoods",BaseUrl]

// 2.5    保存首页点过的菜
#define SetTempFoods  [NSString stringWithFormat:@"%@/api/HomePage/SetTempFoods",BaseUrl]

// 2.9    获取预定菜品的标签
#define GetReserveTags  [NSString stringWithFormat:@"%@/api/HomePage/GetReserveTags",BaseUrl]

// 2.10    根据标签获取预定菜品
#define GetReserveFoods  [NSString stringWithFormat:@"%@/api/HomePage/GetReserveFoods",BaseUrl]

// 2.2    修改订单
#define PlaceOrder  [NSString stringWithFormat:@"%@/api/Order/PlaceOrder",BaseUrl]

// 2.7    下单
#define ToPayPage  [NSString stringWithFormat:@"%@/api/HomePage/ToPayPage",BaseUrl]

// 4.1    预定菜单页进入支付页
#define ToReservePayPage  [NSString stringWithFormat:@"%@/api/HomePage/ToReservePayPage",BaseUrl]

// 2.2    修改预定订单
#define PlaceReserveOrder  [NSString stringWithFormat:@"%@/api/order/PlaceReserveOrder",BaseUrl]


// 3.2    创建未支付订单
#define CreateOrder  [NSString stringWithFormat:@"%@/api/Order/CreateOrder",BaseUrl]

// 4.3    创建未支付预定单
#define CreateReserveOrder  [NSString stringWithFormat:@"%@/api/Order/CreateReserveOrder",BaseUrl]

// 3.3    支付
#define PayOrder2  [NSString stringWithFormat:@"%@/api/Order/PayOrder2",BaseUrl]

// 4.4    预订单支付
#define PayReserveOrder  [NSString stringWithFormat:@"%@/api/Order/PayReserveOrder",BaseUrl]

// 3.3    充值
#define Charge  [NSString stringWithFormat:@"%@/api/user/Charge",BaseUrl]

// 4.6    提现
#define TakeCash  [NSString stringWithFormat:@"%@/api/user/TakeCash",BaseUrl]

// 4.5    查看收支明细
#define GetPayRecord  [NSString stringWithFormat:@"%@/api/user/GetPayRecord",BaseUrl]

// 2.1    用户所在区域
#define GetArea  [NSString stringWithFormat:@"%@/api/HomePage/GetArea",BaseUrl]


// 2.3    首页配送中订单
#define GetSendingOrder  [NSString stringWithFormat:@"%@/api/HomePage/GetSendingOrder",BaseUrl]

// 2.4    获取周围骑手
#define GetRiders  [NSString stringWithFormat:@"%@/api/HomePage/GetRiders",BaseUrl]

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

// 4.4    获取个人余额和优惠券
#define GetWallet  [NSString stringWithFormat:@"%@/api/user/GetWallet",BaseUrl]

// 5.10    兑换优惠券
#define ConvertCoupon  [NSString stringWithFormat:@"%@/api/user/ConvertCoupon",BaseUrl]

// 用户选择地址
#define ChooseAddress  [NSString stringWithFormat:@"%@/api/UserAddress/ChooseAddress",BaseUrl]

// 4.3    提交建议反馈
#define Suggest  [NSString stringWithFormat:@"%@/api/user/Suggest",BaseUrl]

// 3.6    进行中订单
#define GetActiveOrder  [NSString stringWithFormat:@"%@/api/Order/GetActiveOrder",BaseUrl]

// 3.8    我的订单-预定订单
#define GetReserveOrder  [NSString stringWithFormat:@"%@/api/Order/GetReserveOrder",BaseUrl]

// 2.8    进入评价页
#define ToCommentPage  [NSString stringWithFormat:@"%@/api/HomePage/ToCommentPage",BaseUrl]


// 3.8    评价
#define AddComment  [NSString stringWithFormat:@"%@/api/Order/AddComment",BaseUrl]

// 3.4    取消订单
#define UserCancelOrder  [NSString stringWithFormat:@"%@/api/Order/UserCancelOrder",BaseUrl]

// 3.11    通知回收 可回收订单
#define RequestRecovery  [NSString stringWithFormat:@"%@/api/Order/RequestRecovery",BaseUrl]

// 3.6    我的订单-历史订单
#define GetHistoryOrder  [NSString stringWithFormat:@"%@/api/Order/GetHistoryOrder",BaseUrl]

// 3.7    获取单个订单信息
#define GetOrderByOrderId  [NSString stringWithFormat:@"%@/api/Order/GetOrderByOrderId",BaseUrl]

// 3.7    获取消息
#define GetAricleList  [NSString stringWithFormat:@"%@/api/HomePage/GetAricleList",BaseUrl]

// 5.11    判断用户是否点过文章
#define IsUserClicked  [NSString stringWithFormat:@"%@/api/user/IsUserClicked",BaseUrl]

// 5.12    记录用户进过目前的文章列表
#define SetUserClicked  [NSString stringWithFormat:@"%@/api/user/SetUserClicked",BaseUrl]


// 2.11    获取公告
#define GetNotice  [NSString stringWithFormat:@"%@/api/HomePage/GetNotice",BaseUrl]

// 5.8    上传打开app的地点
#define UploadUserLocation  [NSString stringWithFormat:@"%@/api/user/UploadUserLocation",BaseUrl]

// 5.9    上传关闭app的时间
#define UploadUserClose  [NSString stringWithFormat:@"%@/api/user/UploadUserClose",BaseUrl]

#endif /* UrlFile_h */
