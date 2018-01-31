//
//  SystemMsgDetailVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SystemMsgDetailVC.h"
#import "NSStringExt.h"
#import <WebKit/WebKit.h>


@interface SystemMsgDetailVC ()

@property (strong, nonatomic) WKWebView *webView;


@end

@implementation SystemMsgDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;

    
//    UILabel *contenLab = [UILabel labelWithframe:CGRectMake(0, 0, kScreen_Width, 64) text:@"独立完成项目，从交互原型到效果图设计、切图标注等工作。" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
//    contenLab.numberOfLines = 0;
//    [self.view addSubview:contenLab];
//    contenLab.backgroundColor = [UIColor redColor];

//    CGSize size = [NSString textHeight:model.selfevaluation font:_extraLab.font width:_extraLab.width];
//    _extraLab.height = size.height;
//    _extraLab.text = model.selfevaluation;
    

    // WKWebView必须是全局对象，不然显示不了
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
//    _webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_webView];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    // 3.加载网页
    [_webView loadRequest:request];

    
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
