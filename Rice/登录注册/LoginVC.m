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

@end

@implementation LoginVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithHexStr(@"#F8E249");
    
    // 短信登录
    _validateLoginBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth/2, 22) text:@"短信验证登录" font:[UIFont boldSystemFontOfSize:16] textColor:@"#8B572A" backgroundColor:nil normal:nil selected:nil];
    _validateLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:_validateLoginBtn];
    _validateLoginBtn.tag = 0;
    [_validateLoginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];

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
    [_passwordLoginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];


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
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 92+18, _phone.height)];
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
//    [self.countDownButton addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
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
//    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+15, _phone.width, _phone.height) placeholder:@"请输入您收到的验证码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    [_password setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_password setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    
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
//    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *qqBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth/2+31, wechatBtn.top, wechatBtn.width, wechatBtn.width) text:@"" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"" normal:@"7" selected:nil];
    [self.view addSubview:qqBtn];
    //    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        
        [_passwordLoginBtn setTitleColor:[UIColor colorWithHexString:@"#CD9435"] forState:UIControlStateNormal];
        _passwordLoginLine.hidden = YES;
        
        [_validateLoginBtn setTitleColor:[UIColor colorWithHexString:@"#8B572A"] forState:UIControlStateNormal];
        _validateLoginLine.hidden = NO;
        
        _phone.rightView = self.rightView1;

        self.imgView2.image = [UIImage imageNamed:@"4"];
        _password.placeholder = @"请输入您收到的验证码";
        _password.rightView = nil;
        
        self.forgetBtn.hidden = YES;

    }
    else {
        
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




@end
