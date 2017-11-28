//
//  InputMemberIinfo.m
//  XiaoYing
//
//  Created by yinglaijinrong on 16/6/28.
//  Copyright © 2016年 yinglaijinrong. All rights reserved.
//

#import "InfoChangeController.h"

#define weightNum 3
//#define telNum 11
#define heightNum 3

@interface InfoChangeController ()
{
    UITextField *_tv;
    NSInteger fontNum;      //字数
    NSString *_keyStr;      //要修改的信息的键


}

@property (nonatomic,strong)UILabel *remindLab;
@property (nonatomic,strong)UILabel *limitLab;

@end

@implementation InfoChangeController

//- (void)dealloc
//
//{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 19)];
    
    _tv = [[UITextField alloc] initWithFrame:CGRectMake(0, 12, kScreenWidth, 44)];
    _tv.backgroundColor = [UIColor whiteColor];
//    _tv.delegate = self;
    _tv.text = self.text;
    _tv.leftViewMode = UITextFieldViewModeAlways;
    _tv.leftView = leftView;
    _tv.font = [UIFont systemFontOfSize:16];
    _tv.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_tv becomeFirstResponder];
    [self.view addSubview:_tv];
    _tv.keyboardType = UIKeyboardTypeNumberPad;
    [_tv addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    
    if ([self.title isEqualToString:@"名字"]) {
        _tv.keyboardType = UIKeyboardTypeDefault;

    }
    
    if ([self.title isEqualToString:@"身高"]) {

        fontNum = heightNum;


    } else if ([self.title isEqualToString:@"体重"]) {

        fontNum = weightNum;

    }

    //导航栏的确定按钮
    [self initRightBtn];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:_tv];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.view computeWordCountWithTextView:_tv remindLab:_remindLab warningLabel:_limitLab maxNumber:fontNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//导航栏的确定按钮
- (void)initRightBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#77A72C"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

//右上角按钮点击事件
//保存
- (void)saveAction
{
    if (_tv.text.length == 0) {
        [self.view makeToast:@"请填写"];
        return;
    }
    
    //键盘收起
    [_tv resignFirstResponder];
    
    
    if (self.block) {
        self.block(_tv.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
//    if ([_tv.text isEqualToString:self.text]) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else {
//        
//        
//        
//    }

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)valueChange:(UITextField *)tf
{
    if (tf.text.length > fontNum) {
        tf.text = [tf.text substringToIndex:fontNum];
    }
}



@end
