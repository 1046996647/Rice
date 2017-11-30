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
#import "SGAdvertScrollView.h"
#import "TYCyclePagerView.h"
#import "TYCyclePagerViewCell.h"
#import "LoginVC.h"
#import "BookView.h"
#import "PaymentOrderVC.h"

@interface MainViewController ()<MJCSegmentDelegate,SGAdvertScrollViewDelegate,TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (strong, nonatomic) SGAdvertScrollView *advertScrollViewTop;
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) BookView *bookView;

@property (nonatomic, strong) UIImageView *baseImg;

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UIButton *orderBtn;

@property (nonatomic, strong) UIButton *bookBtn;
@property (nonatomic, strong) UIButton *xiaDanBtn;



@end

@implementation MainViewController
// 添加到self.view上的控件uiviewext失效？？？

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"饭的";
//    self.view.backgroundColor =  [UIColor redColor];

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    UIButton *leftBtn = [UIButton buttonWithframe:leftView.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:@"42" selected:@""];
    [leftView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 20)];
    UIButton *rightBtn = [UIButton buttonWithframe:rightView.bounds text:@"赛银国际广场" font:SystemFont(14) textColor:@"#333333" backgroundColor:nil normal:@"定位" selected:@""];
    [rightView addSubview:rightBtn];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    //    [setBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(rightView.width-6, 0, 6, 20) icon:@"Shape"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imgView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
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
    
    // 广告滚轮
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(17, 37+25, kScreenWidth-34, 32)];
    adView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    adView.layer.cornerRadius = 7;
    adView.layer.masksToBounds = YES;
    adView.layer.borderColor = [UIColor colorWithHexString:@"#DBDBDB"].CGColor;
    adView.layer.borderWidth = .5;
    [self.view addSubview:adView];


    UIImageView *leftImg = [UIImageView imgViewWithframe:CGRectMake(6, 0, 19, 32) icon:@"34"];
    leftImg.contentMode = UIViewContentModeScaleAspectFit;
    [adView addSubview:leftImg];

    _advertScrollViewTop = [[SGAdvertScrollView alloc] initWithFrame:CGRectMake(leftImg.right+10, 0, adView.width-(leftImg.right+10)*2, 32)];
    _advertScrollViewTop.titles = @[@"京东、天猫等 app 首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理", @"建议在 github 上下载"];
    _advertScrollViewTop.titleColor = [UIColor colorWithHexString:@"#666666"];
    _advertScrollViewTop.textAlignment = NSTextAlignmentCenter;
//    _advertScrollViewTop.delegate = self;
    _advertScrollViewTop.titleFont = [UIFont systemFontOfSize:14];
    [adView addSubview:_advertScrollViewTop];

    UIImageView *rightImg = [UIImageView imgViewWithframe:CGRectMake(adView.width-10-5, 0, 10, 32) icon:@"32"];
    rightImg.contentMode = UIViewContentModeScaleAspectFit;
    [adView addSubview:rightImg];

    // 底部视图
    [self initBottomView];
}

- (void)initBottomView
{
    UIImageView *baseImg = [UIImageView imgViewWithframe:CGRectMake(17, kScreenHeight-(35+4+138+8+40+15)-64, 106, 35) icon:@"home_1"];
    [self.view addSubview:baseImg];
    self.baseImg = baseImg;
    
    UIButton *foodBtn = [UIButton buttonWithframe:CGRectMake(baseImg.left, baseImg.top, baseImg.width/2, baseImg.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"" selected:nil];
    [self.view addSubview:foodBtn];
    [foodBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    foodBtn.tag = 0;
    
    UIButton *orderBtn = [UIButton buttonWithframe:CGRectMake(foodBtn.right, baseImg.top, baseImg.width/2, baseImg.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"" selected:nil];
    [self.view addSubview:orderBtn];
    self.orderBtn = orderBtn;
    [orderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.tag = 1;

    // --------------菜单---------------
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.isInfiniteLoop = NO;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
//    pagerView.backgroundColor = [UIColor greenColor];
    
    // 预定菜品
    UIButton *bookBtn = [UIButton buttonWithframe:CGRectMake(foodBtn.left, foodBtn.bottom+150, (kScreenWidth-40-10)/2, 40) text:@"预定菜品" font:SystemFont(17) textColor:@"#444444" backgroundColor:@"#F8E249" normal:@"" selected:nil];
    [self.view addSubview:bookBtn];
    self.bookBtn = bookBtn;
    //1.设置阴影颜色
    self.bookBtn.layer.shadowColor = [UIColor colorWithHexString:@"#DD835E"].CGColor;
    self.bookBtn.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bookBtn.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//        self.xiaDanBtn.layer.shadowRadius = 2;//阴影半径，默认3
    
    // 下单
    UIButton *xiaDanBtn = [UIButton buttonWithframe:CGRectMake(bookBtn.right+10, bookBtn.top, bookBtn.width, bookBtn.height) text:@"￥0     下单" font:SystemFont(17) textColor:@"#444444" backgroundColor:@"#F8E249" normal:@"" selected:nil];
    [self.view addSubview:xiaDanBtn];
    self.xiaDanBtn = xiaDanBtn;
    //1.设置阴影颜色
    self.xiaDanBtn.layer.shadowColor = [UIColor colorWithHexString:@"#DD835E"].CGColor;
    self.xiaDanBtn.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.xiaDanBtn.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//    self.xiaDanBtn.layer.shadowRadius = 2;//阴影半径，默认3
    [xiaDanBtn addTarget:self action:@selector(xiaDanAction) forControlEvents:UIControlEventTouchUpInside];

    
    // ----------订单-----------
    BookView *bookView = [[BookView alloc] initWithFrame:CGRectMake(14, orderBtn.bottom+4, kScreenWidth-28, 136)];
    [self.view addSubview:bookView];
    self.bookView = bookView;
    bookView.hidden = YES;

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, self.orderBtn.bottom+4, kScreenWidth, 138);

}

- (void)selectAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        
        self.pagerView.hidden = NO;
        self.bookView.hidden = YES;

        self.bookBtn.hidden = NO;
        self.xiaDanBtn.hidden = NO;
        
        self.baseImg.image = [UIImage imageNamed:@"home_1"];
    }
    else {
        self.pagerView.hidden = YES;
        self.bookView.hidden = NO;

        self.bookBtn.hidden = YES;
        self.xiaDanBtn.hidden = YES;
        
        self.baseImg.image = [UIImage imageNamed:@"home_2"];

    }
}

- (void)xiaDanAction
{
    PaymentOrderVC *vc = [[PaymentOrderVC alloc] init];
    vc.title = @"支付订单";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftAction
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else {
        //发送通知，执行侧滑
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLeftSlide object:nil];
    }


}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
//    return _datas.count;
    return 5;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.layoutType = TYCyclePagerTransformLayoutLinear;
    layout.itemSize = CGSizeMake(kScreenWidth-30, 138);
    layout.itemSpacing = 2;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}

#pragma mark MJCSegmentDelegate
- (void)mjc_ClickEvent:(UIButton *)tabItem childViewController:(UIViewController *)childViewController segmentInterface:(MJCSegmentInterface *)segmentInterface
{
//    _tag = tabItem.tag;
    NSLog(@"%ld",tabItem.tag);
//
//    if (_tag == 1) {
//        self.viewBtn.hidden =  YES;
//    }
//    else {
//        self.viewBtn.hidden =  NO;
//
//    }
}

#pragma mark SGAdvertScrollViewDelegate
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
//    DetailViewController *nextVC = [[DetailViewController alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
