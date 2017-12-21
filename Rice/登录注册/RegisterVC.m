//
//  RegisterVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RegisterVC.h"
#import "RegexTool.h"
#import "UserProtocolVC.h"

//#define kCountDownForVerifyCodeRegister @"CountDownForVerifyCode"
#define kCountDownForVerifyCodeRegister @"kCountDownForVerifyCodeRegister"

@interface RegisterVC()


@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *validate;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *okPwd;
@property (nonatomic, strong) UIButton *countDownButton;


@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithHexStr(@"#F8E249");
    
    // 手机号
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30+5, 42)];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, leftView.height)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 30, 17) icon:@"5"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    imgView1.center = leftView1.center;
    
    [leftView1 addSubview:imgView1];
    [leftView addSubview:leftView1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 92+18, leftView.height)];
//    self.rightView1 = rightView;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 92, 26);
    rightBtn.center = rightView.center;
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
    rightBtn.layer.borderWidth = .5;
    [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#8B572A"] forState:UIControlStateNormal];
    rightBtn.backgroundColor = colorWithHexStr(@"#FFE690");
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:rightBtn];
    self.countDownButton = rightBtn;
    [rightBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(34, 10, kScreenWidth-34*2, leftView.height) placeholder:@"请输入您的手机号码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _phone.layer.masksToBounds = YES;
    [self.view addSubview:_phone];
    _phone.rightViewMode = UITextFieldViewModeAlways;
    _phone.rightView = rightView;
    [_phone setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_phone setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    
    _phone.text = [InfoCache unarchiveObjectWithFile:@"phone"];
    
    // 验证码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30+5, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, leftView.height)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];

    UIImageView *imgView2 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 30, 17) icon:@"4"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    imgView2.center = leftView1.center;
//    self.imgView2 = imgView2;

    [leftView1 addSubview:imgView2];
    [leftView addSubview:leftView1];

    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+15, _phone.width, _phone.height) placeholder:@"请输入您收到的验证码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _validate.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _validate.layer.masksToBounds = YES;
    [self.view addSubview:_validate];
    [_validate setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_validate setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    _validate.keyboardType = UIKeyboardTypeNumberPad;


    // 密码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30+5, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, leftView.height)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];

    UIImageView *imgView3 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 30, 17) icon:@"3"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    imgView3.center = leftView1.center;
    //    self.imgView2 = imgView2;

    [leftView1 addSubview:imgView3];
    [leftView addSubview:leftView1];

    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, _phone.height)];
    //    self.rightView2 = rightView;

    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 0;

    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _validate.bottom+15, _phone.width, _phone.height) placeholder:@"请设置密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.secureTextEntry = YES;
    [_password setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_password setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];

    // 确认密码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30+5, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, leftView.height)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];

    UIImageView *imgView4 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 30, 17) icon:@"3"];
    imgView4.contentMode = UIViewContentModeScaleAspectFit;
    imgView4.center = leftView1.center;
    //    self.imgView2 = imgView2;

    [leftView1 addSubview:imgView4];
    [leftView addSubview:leftView1];

    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, _phone.height)];
    //    self.rightView2 = rightView;

    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 1;


    _okPwd = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+15, _phone.width, _phone.height) placeholder:@"请再次输入密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _okPwd.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _okPwd.layer.masksToBounds = YES;
    [self.view addSubview:_okPwd];
    _okPwd.rightViewMode = UITextFieldViewModeAlways;
    _okPwd.rightView = rightView;
    _okPwd.secureTextEntry = YES;
    [_okPwd setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_okPwd setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];

    CGFloat bottom = 0;
    if ([self.title isEqualToString:@"注册"]) {
        UILabel *agreeLabel = [UILabel labelWithframe:CGRectMake(_password.left, _okPwd.bottom+10, 90, 14) text:@"注册即表示同意" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
        [self.view addSubview:agreeLabel];

        UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(agreeLabel.right, agreeLabel.top, 74, agreeLabel.height) text:@"《用户协议》" font:[UIFont systemFontOfSize:12] textColor:@"#CD9435" backgroundColor:nil normal:nil selected:nil];
        [self.view addSubview:registerBtn];
        bottom = registerBtn.bottom;
        [registerBtn addTarget:self action:@selector(protocolAction) forControlEvents:UIControlEventTouchUpInside];

    }
    else {
        bottom = _okPwd.bottom+55-28;
    }

    UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(_password.left, bottom+28, _phone.width, _phone.height) text:@"确  定" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    registerBtn.layer.cornerRadius = 7;
    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];
    

}

- (void)protocolAction
{
    UserProtocolVC *vc = [[UserProtocolVC alloc] init];
    vc.title = @"用户协议";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.tag == 0) {
        if (btn.selected) {
            _password.secureTextEntry = NO;
        }
        else {
            _password.secureTextEntry = YES;
            
        }
    }
    else {
        if (btn.selected) {
            _okPwd.secureTextEntry = NO;
        }
        else {
            _okPwd.secureTextEntry = YES;
            
        }
    }

}

- (void)getCodeAction
{
    [self.view endEditing:YES];
    
    if (![RegexTool checkPhone:self.phone.text]) {
        [self.view makeToast:@"无效的手机号"];
        return;
    }
    
    // 开始计时
    [CountDownServer startCountDown:20 identifier:kCountDownForVerifyCodeRegister];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SendMail dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSString *message = [responseObject objectForKey:@"message"];
        [self.navigationController.view makeToast:message];
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)registerAction
{
    [self.view endEditing:YES];
    
    if (self.phone.text.length == 0||
        self.validate.text.length == 0||
        self.password.text.length == 0||
        self.okPwd.text.length == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    if (![self.password.text isEqualToString:self.okPwd.text]) {
        [self.view makeToast:@"密码不一致"];
        return;
        
    }

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    NSString *url = nil;
    if ([self.title isEqualToString:@"注册"]) {
    
        url = Register;
        [paramDic  setValue:self.password.text forKey:@"password"];

    }
    else {
        url = FindPassword;
        [paramDic  setValue:self.password.text forKey:@"newPassword"];

    }
    
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    [paramDic  setValue:self.validate.text forKey:@"verificationCode"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:url dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [InfoCache archiveObject:self.phone.text toFile:@"phone"];
        [InfoCache archiveObject:self.password.text toFile:@"password"];

//        [InfoCache archiveObject:responseObject[@"data"][@"userid"] toFile:@"userid"];
//        [InfoCache archiveObject:responseObject[@"data"][@"siteId"] toFile:@"siteId"];
//        [InfoCache archiveObject:responseObject[@"token"] toFile:@"token"];
        
        // 登录通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:nil];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark-验证码通知方法
- (void)countDownUpdate:(NSNotification *)noti
{
    NSString *identifier = [noti.userInfo objectForKey:@"CountDownIdentifier"];
    if ([identifier isEqualToString:kCountDownForVerifyCodeRegister]) {
        NSNumber *n = [noti.userInfo objectForKey:@"SecondsCountDown"];
        
        [self performSelectorOnMainThread:@selector(updateVerifyCodeCountDown:) withObject:n waitUntilDone:YES];
    }
}

- (void)updateVerifyCodeCountDown:(NSNumber *)num {
    
    if ([num integerValue] == 0){
        
        [self.countDownButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.countDownButton.userInteractionEnabled = YES;
        [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#8B572A"] forState:UIControlStateNormal];
        
    } else {
        [self.countDownButton setTitle:[NSString stringWithFormat:@"已发送(%@)",num] forState:UIControlStateNormal];
        self.countDownButton.userInteractionEnabled = NO;
        [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#DDBA7F"] forState:UIControlStateNormal];
    }
}

@end
