//
//  MarkVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MarkVC.h"

@interface MarkVC ()<UITextViewDelegate>

@property(nonatomic,strong) UILabel *foodRemind;
@property(nonatomic,strong) UITextView *foodTV;

@end

@implementation MarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 36, 22) text:@"完成" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [viewBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
    
    _foodTV = [[UITextView alloc] initWithFrame:CGRectMake(19, 16, kScreenWidth-38, 152*scaleWidth)];
    _foodTV.layer.cornerRadius = 10;
    _foodTV.layer.masksToBounds = YES;
    _foodTV.font = [UIFont systemFontOfSize:13];
    _foodTV.backgroundColor = colorWithHexStr(@"#FEF9DA");
    [self.view addSubview:_foodTV];
    _foodTV.delegate = self;
    _foodTV.tag = 0;

    
    _foodRemind = [UILabel labelWithframe:CGRectMake(16, 8, 200, 16) text:@"请输入备注哦" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#DDBA7F"];
    [_foodTV addSubview:_foodRemind];
    
    if (![self.text isEqualToString:@"口味、偏好等要求"]) {
        _foodTV.text = self.text;
        _foodRemind.hidden = YES;
    }
}

- (void)finishAction
{
    [self.view endEditing:YES];
    
    if (_foodTV.text.length == 0) {
        [self.view makeToast:@"请输入内容"];
        return;
    }
    
    if (self.block) {
        self.block(_foodTV.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == 0) {
        if (textView.text.length < 1) {
            self.foodRemind.hidden = NO;
        }
        else {
            self.foodRemind.hidden = YES;
            
        }
    }
    else {

    }
    
}

@end
