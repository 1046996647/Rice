//
//  MyOrderVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MyOrderVC.h"
#import "MJCSegmentInterface.h"
#import "SendingOrderVC.h"
#import "HistoryOrderVC.h"
#import "BookOrderVC.h"

@interface MyOrderVC ()



@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HistoryOrderVC *vc1 = [[HistoryOrderVC alloc] init];
    
    SendingOrderVC *vc2 = [[SendingOrderVC alloc] init];
    
    BookOrderVC *vc3 = [[BookOrderVC alloc]init];
    
    
    NSArray *vcarrr = @[vc1,vc2,vc3];
    NSArray *titlesArr = @[@"历史订单",@"进行中订单",@"预约订单"];
    for (int i = 0 ; i < vcarrr.count; i++) {//赋值标题
        UIViewController *vc = vcarrr[i];
        vc.title = titlesArr[i];
    }
    
    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.titleBarStyles = MJCTitlesClassicStyle;
    lala.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight);
    lala.titlesViewFrame = CGRectMake(0, 0, 0, 37);
    lala.itemBackColor =  [UIColor clearColor];
    lala.itemTextNormalColor = colorWithHexStr(@"#EDE1CE");;
    lala.itemTextSelectedColor = colorWithHexStr(@"#8B572A");;
    lala.indicatorColor = colorWithHexStr(@"#8B572A");
    lala.isIndicatorsAnimals = YES;
    lala.itemTextFontSize = 14;
    lala.isChildScollEnabled = YES;
    lala.selectedSegmentIndex = self.selectedSegmentIndex;
    lala.indicatorStyles = MJCIndicatorItemTextStyle;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    [lala intoChildControllerArray:vcarrr];
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
