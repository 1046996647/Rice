//
//  BaseViewController.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFCEB"];
    
    // 设置了UIRectEdgeNone之后，你嵌在UIViewController里面的UITableView和UIScrollView就不会穿过UINavigationBar了，同时UIView的控件也回复到了iOS6时代。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.navigationController.childViewControllers.count > 1) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:@"navigationReturnClick"] forState:UIControlStateHighlighted];
        CGRect frame = button.frame;
        frame.size = CGSizeMake(30, 20);
        button.frame = frame;
//        button.backgroundColor = [UIColor greenColor]
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.backButton = button;
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
