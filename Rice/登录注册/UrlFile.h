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
#define Forget_passwd  [NSString stringWithFormat:@"%@/User/forget_passwd",BaseUrl]


// 1.7    验证旧手机验证码
#define Check_phone  [NSString stringWithFormat:@"%@/User/check_phone",BaseUrl]

// 1.8    确认修改手机
#define Alter_phone  [NSString stringWithFormat:@"%@/User/alter_phone",BaseUrl]





// 1.16	上传头像
#define Upload_company_logo  [NSString stringWithFormat:@"%@/User/upload_company_logo",BaseUrl]


#endif /* UrlFile_h */
