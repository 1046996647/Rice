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
    
//    if ([self.title isEqualToString:@"名字"]) {
//        _tv.keyboardType = UIKeyboardTypeDefault;
//
//    }
//
//    if ([self.title isEqualToString:@"身高"]) {
//
//        fontNum = heightNum;
//
//
//    } else if ([self.title isEqualToString:@"体重"]) {
//
//        fontNum = weightNum;
//
//    }

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
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 36, 22) text:@"完成" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [viewBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
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
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:_tv.text forKey:@"name"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SetUserInfo dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        PersonModel *person = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        [InfoCache archiveObject:person toFile:Person];
        
        if (self.block) {
            self.block(_tv.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);        
        
    }];
    



}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)valueChange:(UITextField *)tf
{
    if (tf.text.length > 12) {
        tf.text = [tf.text substringToIndex:12];
    }
}



@end
