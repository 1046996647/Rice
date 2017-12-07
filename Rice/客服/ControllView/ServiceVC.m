//
//  ServiceVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ServiceVC.h"

@interface ServiceVC ()<UITextViewDelegate>

@property(nonatomic,strong) UITextView *tv;
@property(nonatomic,strong) UILabel *remindLabel;


@end

@implementation ServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    textView.delegate = self;
    self.tv = textView;

    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, textView.bottom, kScreenWidth, 8) icon:@"Rectangle 11"];
    [self.view addSubview:imgView];

    
    _remindLabel = [UILabel labelWithframe:CGRectMake(24, 13, 300, 16) text:@"请将您遇到的问题/建议反馈给我们。：）" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [textView addSubview:_remindLabel];
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 22)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"发送" font:SystemFont(17) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [rightView addSubview:viewBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
//    [viewBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.remindLabel.hidden = YES;

    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        self.remindLabel.hidden = NO;
    }
}

/**
 内容将要发生改变编辑 限制输入文本长度 监听TextView 点击了ReturnKey 按钮
 
 @param textView textView
 @param range    范围
 @param text     text
 
 @return BOOL
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        return  YES;
        
    } else  if ([textView.text isEqualToString:@"\n"]) {
        
        //这里写按了ReturnKey 按钮后的代码
        return NO;
    }
    
    if (textView.text.length == 500) {
        
        return NO;
    }
    
    return YES;
    
}


/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    
    self.remindLabel.hidden = YES;

}

@end
