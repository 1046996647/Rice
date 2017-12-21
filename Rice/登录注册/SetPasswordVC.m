//
//  SetPasswordVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SetPasswordVC.h"
#import "UserProtocolVC.h"


@interface SetPasswordVC ()

@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *okPwd;

@end

@implementation SetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = colorWithHexStr(@"#F8E249");
    
    // 密码
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30+5, 42)];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, leftView.height)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView3 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 30, 17) icon:@"3"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    imgView3.center = leftView1.center;
    //    self.imgView2 = imgView2;
    
    [leftView1 addSubview:imgView3];
    [leftView addSubview:leftView1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, leftView.height)];
    //    self.rightView2 = rightView;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 0;
    
    _password = [UITextField textFieldWithframe:CGRectMake(34, 10, kScreenWidth-34*2, leftView.height) placeholder:@"请设置密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
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
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, leftView.height)];
    //    self.rightView2 = rightView;
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 1;
    
    
    _okPwd = [UITextField textFieldWithframe:CGRectMake(_password.left, _password.bottom+15, _password.width, leftView.height) placeholder:@"请再次输入密码" font:nil leftView:leftView backgroundColor:@"#FFEB93"];
    _okPwd.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _okPwd.layer.masksToBounds = YES;
    [self.view addSubview:_okPwd];
    _okPwd.rightViewMode = UITextFieldViewModeAlways;
    _okPwd.rightView = rightView;
    _okPwd.secureTextEntry = YES;
    [_okPwd setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_okPwd setValue:[UIColor colorWithHexString:@"#DDBA7F"] forKeyPath:@"_placeholderLabel.textColor"];
    
    UILabel *agreeLabel = [UILabel labelWithframe:CGRectMake(_password.left, _okPwd.bottom+10, 90, 14) text:@"注册即表示同意" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [self.view addSubview:agreeLabel];
    
    UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(agreeLabel.right, agreeLabel.top, 74, agreeLabel.height) text:@"《用户协议》" font:[UIFont systemFontOfSize:12] textColor:@"#CD9435" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:registerBtn];
//    bottom = registerBtn.bottom;
    [registerBtn addTarget:self action:@selector(protocolAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn1 = [UIButton buttonWithframe:CGRectMake(_password.left, registerBtn.bottom+28, _password.width, leftView.height) text:@"确  定" font:[UIFont systemFontOfSize:16] textColor:@"#CD9435" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    registerBtn1.layer.cornerRadius = 7;
    registerBtn1.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn1];
    [registerBtn1 addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerAction
{
    [self.view endEditing:YES];
    
    if (
        self.password.text.length == 0||
        self.okPwd.text.length == 0
        ) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    if (![self.password.text isEqualToString:self.okPwd.text]) {
        [self.view makeToast:@"密码不一致"];
        return;
        
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [paramDic  setValue:self.password.text forKey:@"password"];
    [paramDic  setValue:self.model.userId forKey:@"userId"];
    [paramDic  setValue:self.model.Token forKey:@"Token"];

    [AFNetworking_RequestData requestMethodPOSTUrl:SetPassword dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [InfoCache archiveObject:self.model toFile:Person];
        
        // 用户信息通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshNotification" object:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
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

- (void)protocolAction
{
    UserProtocolVC *vc = [[UserProtocolVC alloc] init];
    vc.title = @"用户协议";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
