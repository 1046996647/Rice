//
//  ModifyPasswordVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ModifyPasswordVC.h"

@interface ModifyPasswordVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *okPwd;

@end

@implementation ModifyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
    
    // 验证码
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 19, 42)];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(34, 10, kScreenWidth-34*2, leftView.height) placeholder:@"请输入当前密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
//    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _phone.layer.masksToBounds = YES;
    [self.view addSubview:_phone];
    [_phone setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_phone setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 密码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 19, leftView.height)];
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+15, _phone.width, _phone.height) placeholder:@"请输入新密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.secureTextEntry = YES;
    [_password setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_password setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 确认密码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 19, leftView.height)];
    
    _okPwd = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+15, _phone.width, _phone.height) placeholder:@"请再次输入新密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _okPwd.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _okPwd.layer.masksToBounds = YES;
    [self.view addSubview:_okPwd];
    _okPwd.secureTextEntry = YES;
    [_okPwd setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_okPwd setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _okPwd.bottom+55, _phone.width, _phone.height) text:@"确认提交" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    //    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
