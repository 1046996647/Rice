//
//  MainViewController.m
//  CSLeftSlideDemo
//
//  Created by LCS on 16/2/11.
//  Copyright © 2016年 LCS. All rights reserved.
//

#import "MainViewController.h"
#import "Constants.h"
#import "MJCSegmentInterface.h"



@interface MainViewController ()<MJCSegmentDelegate>

@end

@implementation MainViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"饭的";
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    UIButton *leftBtn = [UIButton buttonWithframe:leftView.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:@"42" selected:@""];
    [leftView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    UIButton *rightBtn = [UIButton buttonWithframe:leftView.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:@"41" selected:@""];
    [rightView addSubview:rightBtn];
    //    [setBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    NSArray *titlesArr = @[@"全部",@"中餐",@"日料",@"西餐",@"西餐1",@"西餐2",@"西餐3",@"西餐4",@"西餐5",@"西餐6"];
    
    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.titleBarStyles = MJCTitlesScrollStyle;
    lala.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight);
    lala.titlesViewFrame = CGRectMake(0, 0, 0, 37);
    lala.itemBackColor =  [UIColor clearColor];
    lala.itemTextNormalColor = colorWithHexStr(@"#EFCBD0");;
    lala.itemTextSelectedColor = colorWithHexStr(@"#D0021B");;
    lala.indicatorColor = colorWithHexStr(@"#D0021B");
    lala.isIndicatorsAnimals = YES;
    lala.itemTextFontSize = 12;
    lala.isChildScollEnabled = NO;
    //    lala.selectedSegmentIndex = 2;
    lala.indicatorStyles = MJCIndicatorItemTextStyle;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
//    [lala intoChildControllerArray:vcarrr];
    lala.delegate  = self;
    
}

- (void)leftAction
{
    //发送通知，执行侧滑
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLeftSlide object:nil];
}

#pragma mark MJCSegmentDelegate
- (void)mjc_ClickEvent:(UIButton *)tabItem childViewController:(UIViewController *)childViewController segmentInterface:(MJCSegmentInterface *)segmentInterface
{
//    _tag = tabItem.tag;
//    NSLog(@"%ld",_tag);
//
//    if (_tag == 1) {
//        self.viewBtn.hidden =  YES;
//    }
//    else {
//        self.viewBtn.hidden =  NO;
//
//    }
}

@end
