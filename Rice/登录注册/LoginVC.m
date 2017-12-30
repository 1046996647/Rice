//
//  LoginVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "LoginVC.h"
#import "NSStringExt.h"
#import "RegisterVC.h"
#import "RegexTool.h"
#import "PhoneBindingVC.h"
#import "SetPasswordVC.h"
#import <UMSocialCore/UMSocialCore.h>

#define kCountDownForVerifyCode @"CountDownForVerifyCode"


@interface LoginVC()

@property(nonatomic,strong) UIButton *validateLoginBtn;
@property(nonatomic,strong) UIView *validateLoginLine;

@property(nonatomic,strong) UIButton *passwordLoginBtn;
@property(nonatomic,strong) UIView *passwordLoginLine;

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property (nonatomic, strong) UIButton *countDownButton;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIView *rightView1;
@property (nonatomic, strong) UIView *rightView2;

@property (nonatomic, assign) NSInteger wayTag;// 登录方式


@end

@implementation LoginVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithHexStr(@"#F8E249");
    
    // 短信登录
    _validateLoginBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth/2, 22) text:@"短信验证登录" font:[UIFont boldSystemFontOfSize:16] textColor:@"#8B572A" backgroundColor:nil normal:nil selected:nil];
    _validateLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:_validateLoginBtn];
    _validateLoginBtn.tag = 0;
    [_validateLoginBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];

    CGSize size1 = [NSString textLength:_validateLoginBtn.currentTitle font:_validateLoginBtn.titleLabel.font];
    _validateLoginLine = [[UIView alloc] initWithFrame:CGRectMake((_validateLoginBtn.width-size1.width)/2, _validateLoginBtn.bottom-3, size1.width, 3)];
    _validateLoginLine.layer.cornerRadius = _validateLoginLine.height/2;
    _validateLoginLine.layer.masksToBounds = YES;
    _validateLoginLine.backgroundColor = colorWithHexStr(@"#8B572A");
    [_validateLoginBtn addSubview:_validateLoginLine];
    
    // 密码登录
    _passwordLoginBtn = [UIButton buttonWithframe:CGRectMake(_validateLoginBtn.right, 10, kScreenWidth/2, 22) text:@"密码登录" font:[UIFont boldSystemFontOfSize:16] textColor:@"#CD9435" backgroundColor:nil normal:nil selected:nil];
    _passwordLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:_passwordLoginBtn];
    _passwordLoginBtn.tag = 1;
    [_passwordLoginBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];


    [_passwordLoginBtn setTitleColor:[UIColor colorWithHexString:@"#CD9435"] forState:UIControlStateNormal];
    [_passwordLoginBtn setTitleColor:[UIColor colorWithHexString:@"#8B572A"] forState:UIControlStateSelected];
    
    CGSize size2 = [NSString textLength:_passwordLoginBtn.currentTitle font:_passwordLoginBtn.titleLabel.font];
    _passwordLoginLine = [[UIView alloc] initWithFrame:CGRectMake((_passwordLoginBtn.width-size2.width)/2, _validateLoginBtn.bottom-3, size2.width, 3)];
    _passwordLoginLine.layer.cornerRadius = _passwordLoginLine.height/2;
    _passwordLoginLine.layer.masksToBounds = YES;
    _passwordLoginLine.backgroundColor = colorWithHexStr(@"#8B572A");
    _passwordLoginLine.hidden = YES;
    [_passwordLoginBtn addSubview:_passwordLoginLine];
    
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
    self.rightView1 = rightView;
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
    [self.countDownButton addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(34, _passwordLoginLine.bottom+52, kScreenWidth-34*2, leftView.height) placeholder:@"请输入您的手机号码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
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
    
    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30+5, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, leftView.height)];
//    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView2 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 30, 17) icon:@"4"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    imgView2.center = leftView1.center;
    self.imgView2 = imgView2;
    
    [leftView1 addSubview:imgView2];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, _phone.height)];
    self.rightView2 = rightView;

    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+15, _phone.width, _phone.height) placeholder:@"请输入您收到的验证码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    [_password setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_password setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
//    _password.keyboardType = UIKeyboardTypeNumberPad;

    
    UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(_password.right-50-5, _password.bottom+10, 50, 14) text:@"立即注册" font:[UIFont systemFontOfSize:12] textColor:@"#8B572A" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn = registerBtn;
    
    UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(_password.left+5, registerBtn.top, registerBtn.width, registerBtn.height) text:@"忘记密码" font:[UIFont systemFontOfSize:12] textColor:@"#8B572A" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    self.forgetBtn = forgetBtn;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, forgetBtn.bottom+28, _phone.width, _phone.height) text:@"登  录" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 其他登录方式
    UIImageView *wayView = [UIImageView imgViewWithframe:CGRectMake(27, loginBtn.bottom+193*scaleWidth, kScreenWidth-54, 12) icon:@"Group 5"];
    [self.view addSubview:wayView];
    
    UIButton *wechatBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth/2-40-31, wayView.bottom+25*scaleWidth, 40, 40) text:@"" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"" normal:@"8" selected:nil];
    [self.view addSubview:wechatBtn];
    [wechatBtn addTarget:self action:@selector(thirdpartLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    wechatBtn.tag = 0;

    
    UIButton *qqBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth/2+31, wechatBtn.top, wechatBtn.width, wechatBtn.width) text:@"" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"" normal:@"7" selected:nil];
    [self.view addSubview:qqBtn];
    [qqBtn addTarget:self action:@selector(thirdpartLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    qqBtn.tag = 1;
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];
    
    //登录通知事件
    NSNotificationCenter *LoginCenter = [NSNotificationCenter defaultCenter];
    [LoginCenter addObserver:self selector:@selector(kLoginAction) name:@"kLoginNotification" object:nil];
}




- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
        
        if (platformType == UMSocialPlatformType_QQ) {
            [paramDic  setValue:resp.uid forKey:@"qq"];
            [paramDic  setValue:@"QQ" forKey:@"LoginMode"];

        }
        else {
            [paramDic  setValue:resp.uid forKey:@"wechat"];
            [paramDic  setValue:@"WeChat" forKey:@"LoginMode"];
        }
        [paramDic  setValue:[InfoCache unarchiveObjectWithFile:@"pushToken"] forKey:@"deviceToken"];
        [paramDic  setValue:@"ios" forKey:@"deviceType"];


        [AFNetworking_RequestData requestMethodPOSTUrl:Login dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
 
            PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];

            if (model.phone.length == 0) {// 未绑定手机
                
                PhoneBindingVC *vc = [[PhoneBindingVC alloc] init];
                vc.title = @"绑定手机";
                vc.platformType = platformType;
                vc.uid = resp.uid;
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (!model.hasPwd) {// 未绑定手机
                
                SetPasswordVC *vc = [[SetPasswordVC alloc] init];
                vc.title = @"设置密码";
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                
                [InfoCache archiveObject:model toFile:Person];
                
                // 用户信息通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }

            
            
        } failure:^(NSError *error) {
            
        }];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _phone.text = [InfoCache unarchiveObjectWithFile:@"phone"];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        _password.secureTextEntry = NO;
    }
    else {
        _password.secureTextEntry = YES;
        
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
    [CountDownServer startCountDown:20 identifier:kCountDownForVerifyCode];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SendMail dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            NSString *message = [responseObject objectForKey:@"message"];
            [self.navigationController.view makeToast:message];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

// 通知方法
- (void)kLoginAction
{
    self.wayTag = 1;
    _phone.text = [InfoCache unarchiveObjectWithFile:@"phone"];
    _password.text = [InfoCache unarchiveObjectWithFile:@"password"];

    [self loginAction];
}

- (void)loginAction
{
    [self.view endEditing:YES];
    
    if (self.phone.text.length == 0||
        self.password.text.length == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
//    NSString *url = nil;
    if (self.wayTag == 0) {
        
//        url = Login;
        [paramDic  setValue:self.phone.text forKey:@"phone"];
        [paramDic  setValue:self.password.text forKey:@"verificationCode"];
        [paramDic  setValue:@"Mail" forKey:@"LoginMode"];

    }
    else {
//        url = @"asfsdf";
        [paramDic  setValue:self.phone.text forKey:@"phone"];
        [paramDic  setValue:self.password.text forKey:@"password"];
        [paramDic  setValue:@"Password" forKey:@"LoginMode"];

    }

    [paramDic  setValue:[InfoCache unarchiveObjectWithFile:@"pushToken"] forKey:@"deviceToken"];
    [paramDic  setValue:@"ios" forKey:@"deviceType"];

    
    [AFNetworking_RequestData requestMethodPOSTUrl:Login dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [InfoCache archiveObject:self.phone.text toFile:@"phone"];

        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        
        if (model.hasPwd) {
            
            [InfoCache archiveObject:model toFile:Person];
            
            // 用户信息通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshNotification" object:nil];
            
            if (self.level == 1) {
                [self.navigationController popViewControllerAnimated:YES];

            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];

            }
        }
        else {
            
            SetPasswordVC *vc = [[SetPasswordVC alloc] init];
            vc.title = @"设置密码";
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)thirdpartLoginAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];

    }
    if (btn.tag == 1) {
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
    }
}

- (void)changeAction:(UIButton *)btn
{
    self.wayTag = btn.tag;

    if (btn.tag == 0) {
        
        [_passwordLoginBtn setTitleColor:[UIColor colorWithHexString:@"#CD9435"] forState:UIControlStateNormal];
        _passwordLoginLine.hidden = YES;
        
        [_validateLoginBtn setTitleColor:[UIColor colorWithHexString:@"#8B572A"] forState:UIControlStateNormal];
        _validateLoginLine.hidden = NO;
        
        _phone.rightView = self.rightView1;

        self.imgView2.image = [UIImage imageNamed:@"4"];
        _password.placeholder = @"请输入您收到的验证码";
        _password.rightView = nil;
        _password.secureTextEntry = NO;

        
        self.forgetBtn.hidden = YES;

    }
    else {
        self.password.text = @"";
        
        [_passwordLoginBtn setTitleColor:[UIColor colorWithHexString:@"#8B572A"] forState:UIControlStateNormal];
        _passwordLoginLine.hidden = NO;
        
        [_validateLoginBtn setTitleColor:[UIColor colorWithHexString:@"#CD9435"] forState:UIControlStateNormal];
        _validateLoginLine.hidden = YES;
        
        self.forgetBtn.hidden = NO;

        _phone.rightView = nil;

        self.imgView2.image = [UIImage imageNamed:@"3"];
        _password.placeholder = @"请输入密码";
        _password.rightView = self.rightView2;
        _password.secureTextEntry = YES;
    }
}

- (void)registerAction
{
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetAction
{
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.title = @"密码找回";
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark-验证码通知方法
- (void)countDownUpdate:(NSNotification *)noti
{
    NSString *identifier = [noti.userInfo objectForKey:@"CountDownIdentifier"];
    if ([identifier isEqualToString:kCountDownForVerifyCode]) {
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
