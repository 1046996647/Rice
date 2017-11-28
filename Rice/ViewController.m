//
//  ViewController.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ViewController.h"
#import "NavigationController.h"
#import "MainViewController.h"
#import "CSLeftSlideControllerTwo.h"
#import "LeftViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavigationController *mainNav = [[NavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];

    LeftViewController *leftVC = [[LeftViewController alloc] init];

    //    初始化CSLeftSlideControllerTwo（主界面不跟着移动）
    CSLeftSlideControllerTwo *LeftSlideController = [[CSLeftSlideControllerTwo alloc] initWithLeftViewController:leftVC MainViewController:mainNav];
    [self addChildViewController:LeftSlideController];
    [self.view addSubview:LeftSlideController.view];
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
