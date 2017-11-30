//
//  BookFoodVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookFoodVC.h"
#import "MJCSegmentInterface.h"


@interface BookFoodVC ()<MJCSegmentDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation BookFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titlesArr = @[@"中餐",@"日料",@"西餐",@"西餐1",@"西餐2",@"西餐3",@"西餐4",@"西餐5",@"西餐6"];
    
    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.titleBarStyles = MJCTitlesScrollStyle;
    lala.frame = CGRectMake(0, 0, kScreenWidth, 37);
    //    lala.titlesViewFrame = CGRectMake(0, 0, 0, 37);
    //    lala.titlesViewBackImage =  [UIImage imageNamed:@"nav-background"];
    lala.titlesViewBackColor = [UIColor colorWithHexString:@"#F8E249"];
    lala.itemBackColor =  [UIColor clearColor];
    lala.itemTextNormalColor = colorWithHexStr(@"#CD9435");;
    lala.itemTextSelectedColor = colorWithHexStr(@"#444444");;
    //    lala.indicatorColor = colorWithHexStr(@"#D0021B");
    lala.indicatorHidden = YES;
    lala.isIndicatorsAnimals = YES;
    lala.itemTextFontSize = 14;
    lala.isChildScollEnabled = NO;
    //    lala.selectedSegmentIndex = 2;
    lala.indicatorStyles = MJCIndicatorItemTextStyle;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    //    [lala intoChildControllerArray:vcarrr];
    lala.delegate  = self;
    lala.backgroundColor = [UIColor clearColor];
    //1.设置阴影颜色
    lala.layer.shadowColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
    lala.layer.shadowOffset = CGSizeMake(0,.5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    lala.layer.shadowOpacity = 1;//阴影透明度，默认0
    //    self.xiaDanBtn.layer.shadowRadius = 2;//阴影半径，默认3
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
