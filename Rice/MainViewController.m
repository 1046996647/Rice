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
#import "SearchAddressVC.h"
#import "PaymentOrderVC.h"
#import "NSStringExt.h"
#import "RiderModel.h"
#import <QMapKit/QMapKit.h>
#import <TencentLBS/TencentLBS.h>
//#import "CAAnimation+HCAnimation.h"


@interface MainViewController ()<MJCSegmentDelegate,SGAdvertScrollViewDelegate,TYCyclePagerViewDataSource, TYCyclePagerViewDelegate,QMapViewDelegate,TencentLBSLocationManagerDelegate>

@property (strong, nonatomic) SGAdvertScrollView *advertScrollViewTop;
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) BookView *bookView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) MJCSegmentInterface *lala;
@property (nonatomic, strong) UIView *adView;


@property (nonatomic, strong) UIImageView *baseImg;
@property (nonatomic, strong) UIImageView *pinView1;


@property (nonatomic, strong) UIButton *orderBtn;

@property (nonatomic, strong) UIButton *bookBtn;
@property (nonatomic, strong) UIButton *xiaDanBtn;
@property (nonatomic, strong) NSArray *tagArrs;// 标签数组
@property (nonatomic, strong) NSArray *foodArrs;// 菜品数组
@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSDictionary *areaDic;


@property (nonatomic, strong) NSMutableArray *selectedArr;// 选中菜品数组
@property (nonatomic, strong) NSMutableArray *foodIdArr;// id数组
@property (nonatomic, assign) float totalPrice;// 总费用

// 地图
@property (nonatomic, strong) QMapView *mapView;
@property (readwrite, nonatomic, strong) TencentLBSLocationManager *locationManager;
//@property (nonatomic, strong) TencentLBSLocation *location;
@property(nonatomic, nonatomic) CLLocationCoordinate2D coordinate;



@end

@implementation MainViewController
// 添加到self.view上的控件uiviewext失效？？？

- (MJCSegmentInterface *)lala
{
    if (!_lala) {
        //以下是我的控件中的代码
        _lala = [[MJCSegmentInterface alloc]init];
        _lala.titleBarStyles = MJCTitlesScrollStyle;
        _lala.frame = CGRectMake(0, 0, kScreenWidth, 37);
        //    lala.titlesViewFrame = CGRectMake(0, 0, 0, 37);
        //    lala.titlesViewBackImage =  [UIImage imageNamed:@"nav-background"];
        _lala.titlesViewBackColor = [UIColor colorWithHexString:@"#F8E249"];
        _lala.itemBackColor =  [UIColor clearColor];
        _lala.itemTextNormalColor = colorWithHexStr(@"#CD9435");;
        _lala.itemTextSelectedColor = colorWithHexStr(@"#444444");;
        //    lala.indicatorColor = colorWithHexStr(@"#D0021B");
        _lala.indicatorHidden = YES;
        _lala.isIndicatorsAnimals = YES;
        _lala.itemTextFontSize = 14;
        _lala.isChildScollEnabled = NO;
        //        lala.selectedSegmentIndex = 2;
        _lala.indicatorStyles = MJCIndicatorItemTextStyle;
        //    [lala intoTitlesArray:titlesArr hostController:self];
        [self.view addSubview:_lala];
        //    [lala intoChildControllerArray:vcarrr];
        _lala.delegate  = self;
        _lala.backgroundColor = [UIColor clearColor];
        //1.设置阴影颜色
        _lala.layer.shadowColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
        _lala.layer.shadowOffset = CGSizeMake(0,.5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _lala.layer.shadowOpacity = 1;//阴影透明度，默认0
        //    self.xiaDanBtn.layer.shadowRadius = 2;//阴影半径，默认3
        _lala.hidden = YES;
    }
    return _lala;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"饭的";
//    self.view.backgroundColor =  [UIColor redColor];

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    UIButton *leftBtn = [UIButton buttonWithframe:leftView.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:@"42" selected:@""];
    [leftView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    // 赛银国际广场
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 20)];
    UIButton *rightBtn = [UIButton buttonWithframe:rightView.bounds text:@"" font:SystemFont(14) textColor:@"#333333" backgroundColor:nil normal:@"定位" selected:@""];
    [rightView addSubview:rightBtn];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [rightBtn addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = rightBtn;
    rightBtn.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(rightView.width-6, 0, 6, 20) icon:@"Shape"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imgView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    // 地图mapview
    _mapView = [[QMapView alloc] initWithFrame:CGRectMake(0,
                                                          0,
                                                          kScreenWidth,
                                                          kScreenHeight+64)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView setZoomLevel:15.01];
    _mapView.showsUserLocation = NO;// 默认是NO

    // 去掉logo
    for (UIView *view in _mapView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
    
    
    // 大头针
    UIImageView *pinView1 = [UIImageView imgViewWithframe:CGRectMake(0, (kScreenHeight-kTopHeight-34)/2, _mapView.width, 34) icon:@"14"];
    pinView1.contentMode = UIViewContentModeScaleAspectFit;
//    pinView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:pinView1];
    self.pinView1 = pinView1;
    
    [self configLocationManager];
    [self startUpdatingLocation];
    
//    NSArray *titlesArr = @[@"中餐",@"日料",@"西餐",@"西餐1",@"西餐2",@"西餐3",@"西餐4",@"西餐5",@"西餐6"];

    

    
    // 广告滚轮
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(17, 37+25, kScreenWidth-34, 32)];
    adView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    adView.layer.cornerRadius = 7;
    adView.layer.masksToBounds = YES;
    adView.layer.borderColor = [UIColor colorWithHexString:@"#DBDBDB"].CGColor;
    adView.layer.borderWidth = .5;
    [self.view addSubview:adView];
    self.adView = adView;

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
    
    // 选中菜品数组
    self.selectedArr = [NSMutableArray array];
    // id数组
    self.foodIdArr = [NSMutableArray array];
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
    UIButton *xiaDanBtn = [UIButton buttonWithframe:CGRectMake(bookBtn.right+10, bookBtn.top, bookBtn.width, bookBtn.height) text:[NSString stringWithFormat:@"￥%.2f     下单",self.totalPrice] font:SystemFont(17) textColor:@"#444444" backgroundColor:@"#F8E249" normal:@"" selected:nil];
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
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (model) {
        [self getSendingOrder];
        
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, self.orderBtn.bottom+4, kScreenWidth, 138);
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)addressAction
{
//    SearchAddressVC *vc = [[SearchAddressVC alloc] init];
//    vc.title = @"当前位置";
//    [self.navigationController pushViewController:vc animated:YES];
}

// 2.1    用户所在区域
- (void)getArea
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic  setValue:@(self.coordinate.latitude) forKey:@"lat"];
    [paramDic  setValue:@(self.coordinate.longitude) forKey:@"lng"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetArea dic:paramDic showHUD:YES response:YES Succed:^(id responseObject) {
        
        id obj = responseObject[@"data"];
        if ([obj isKindOfClass:[NSArray class]]) {
            
            self.areas = obj;

            if (self.areas.count > 0) {
                self.areaDic = self.areas[0];
                [self.rightBtn setTitle:self.areaDic[@"areaName"] forState:UIControlStateNormal];
                
                
                [self getTags];
            }


        }
        
    } failure:^(NSError *error) {
        
    }];
}

// 获取标签
- (void)getTags
{

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
//    [paramDic  setValue:@(self.location.location.coordinate.latitude) forKey:@"lat"];
//    [paramDic  setValue:@(self.location.location.coordinate.longitude) forKey:@"lng"];
    [paramDic  setValue:self.areaDic[@"areaId"] forKey:@"areaId"];

    [AFNetworking_RequestData requestMethodPOSTUrl:GetTags dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        [_lala removeFromSuperview];
        _lala = nil;
        [self.view addSubview:self.lala];

        NSArray *arr = responseObject[@"data"];
        self.tagArrs = arr;
        if ([arr isKindOfClass:[NSArray class]]) {
            
            if (arr.count < 4) {
                self.lala.hidden = YES;
                self.adView.top = 25;
                [self getFoods:@""];
            }
            else {
                self.lala.hidden = NO;

                NSMutableArray *tagArr = [NSMutableArray array];
                for (NSDictionary *dic in arr) {
                    [tagArr addObject:dic[@"tagName"]];
                }
                [self.lala intoTitlesArray:tagArr hostController:self];


                // 取出第一个tagId
                NSDictionary *dic = [arr firstObject];
                NSString *tagId = dic[@"tagId"];
                [self getFoods:tagId];
            }

        }
        
    } failure:^(NSError *error) {
        
    }];
}

// 首页菜品接口
- (void)getFoods:(NSString *)tagId
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
//    [paramDic  setValue:@(self.location.location.coordinate.latitude) forKey:@"lat"];
//    [paramDic  setValue:@(self.location.location.coordinate.longitude) forKey:@"lng"];
    [paramDic  setValue:tagId forKey:@"tagId"];
    [paramDic  setValue:self.areaDic[@"areaId"] forKey:@"areaId"];


    [AFNetworking_RequestData requestMethodPOSTUrl:GetFoods dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"][@"foods"];
        if ([arr isKindOfClass:[NSArray class]]) {

            NSMutableArray *foodArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                FoodModel *model = [FoodModel yy_modelWithJSON:dic];
                [foodArr addObject:model];
                
                // 取得数量大于0且唯一的id
                if (model.amount > 0) {
                    if (![self.foodIdArr containsObject:model.foodId]) {
                        [self.foodIdArr addObject:model.foodId];
                        
                        // 确保保存唯一id的model
                        [self.selectedArr addObject:model];
                    }
                }
                else {
                    
                    for (FoodModel *model1 in self.selectedArr) {
                        if ([model1.foodId isEqualToString:model.foodId]) {
                            model1.amount = model.amount;

                            
                        }
                    }
                    
                }

            }
            self.foodArrs = foodArr;
            [_pagerView reloadData];

            [_pagerView scrollToItemAtIndex:0 animate:NO];

            // 保存过的菜单
            self.totalPrice = 0;
            for (FoodModel *model1 in self.selectedArr) {
                self.totalPrice = self.totalPrice+model1.foodPrice.floatValue*model1.amount.floatValue;
            }
            
            [self.xiaDanBtn setTitle:[NSString stringWithFormat:@"￥%.2f     下单",self.totalPrice] forState:UIControlStateNormal];
            
            // 骑手数据
            FoodModel *model1 = [self.foodArrs firstObject];
            [self getRiders:model1.foodId];

        }
        
    } failure:^(NSError *error) {
        
    }];
}

// 首页配送中订单
- (void)getSendingOrder
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetSendingOrder dic:paramDic showHUD:NO response:YES Succed:^(id responseObject) {
        
        id obj = responseObject[@"data"];
        self.bookView.dic = obj;

        
    } failure:^(NSError *error) {
        
    }];
}

// 2.4    获取周围骑手
- (void)getRiders:(NSString *)foodId
{
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic  setValue:@(self.coordinate.latitude) forKey:@"lat"];
    [paramDic  setValue:@(self.coordinate.longitude) forKey:@"lng"];
    [paramDic  setValue:self.areaDic[@"areaId"] forKey:@"areaId"];
    [paramDic  setValue:foodId forKey:@"foodId"];

    [AFNetworking_RequestData requestMethodPOSTUrl:GetRiders dic:paramDic showHUD:NO response:YES Succed:^(id responseObject) {
        
        [_mapView removeAnnotations:_annotations];

        
        id obj = responseObject[@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in obj) {
            RiderModel *model = [RiderModel yy_modelWithJSON:dic];
            
            QPointAnnotation *sigma = [[QPointAnnotation alloc] init];
            sigma.title = model.riderType;
            sigma.coordinate = CLLocationCoordinate2DMake(model.lat.doubleValue,model.lng.doubleValue);
            [arrM addObject:sigma];

        }
        self.annotations = arrM;
        
        if (self.annotations) {
            [_mapView addAnnotations:_annotations];

        }
        
        
    } failure:^(NSError *error) {
        
    }];
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

        PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
        if (!model) {
            LoginVC *vc = [[LoginVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            vc.block = ^{
                [self getSendingOrder];

            };
            return;
        }
//        [self getSendingOrder];
    }
}

- (void)xiaDanAction
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (self.totalPrice == 0) {
        [self.navigationController.view makeToast:@"请选择菜品"];
        return;

    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (FoodModel *model in self.selectedArr) {
        if (model.amount.integerValue > 0) {
            NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.foodId,@"foodId", model.amount,@"amount", nil];
            [arrM addObject:paramDic];
        }

    }
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic setValue:@"1" forKey:@"isUseBalance"];
    [paramDic setValue:@"1" forKey:@"isUseCoupon"];
    
    NSString *jsonStr = [NSString JSONString:arrM];
    [paramDic setValue:jsonStr forKey:@"listFoods"];
    
    NSLog(@"paramDic:%@",paramDic);

    PaymentOrderVC *vc = [[PaymentOrderVC alloc] init];
    vc.title = @"支付订单";
    vc.param = paramDic;
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
    return self.foodArrs.count;
//    return 5;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
//    cell.backgroundColor = [UIColor redColor];
    FoodModel *model = self.foodArrs[index];
    cell.model = model;
    cell.block = ^(FoodModel *model,NSInteger tag) {
        
        PersonModel *personModel = [InfoCache unarchiveObjectWithFile:Person];
        if (!personModel) {
            LoginVC *vc = [[LoginVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }

        if (![self.foodIdArr containsObject:model.foodId]) {
            [self.foodIdArr addObject:model.foodId];
            
            // 确保保存唯一id的model
            [self.selectedArr addObject:model];
        }
        else {
            
            for (FoodModel *model1 in self.selectedArr) {
                if ([model1.foodId isEqualToString:model.foodId]) {
                    model1.amount = model.amount;

                }
            }

        }

        self.totalPrice = 0;
        for (FoodModel *model1 in self.selectedArr) {
            self.totalPrice = self.totalPrice+model1.foodPrice.floatValue*model1.amount.floatValue;
            NSLog(@"---id%@",model1.foodId);

        }
        
        NSLog(@"---totalPrice%.2f",self.totalPrice);

        [self.xiaDanBtn setTitle:[NSString stringWithFormat:@"￥%.2f     下单",self.totalPrice] forState:UIControlStateNormal];
    };
    
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

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    FoodModel *model = self.foodArrs[toIndex];
    [self getRiders:model.foodId];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

#pragma mark MJCSegmentDelegate
- (void)mjc_ClickEvent:(UIButton *)tabItem childViewController:(UIViewController *)childViewController segmentInterface:(MJCSegmentInterface *)segmentInterface
{
//    _tag = tabItem.tag;
    NSLog(@"%ld",tabItem.tag);

    NSDictionary *dic = self.tagArrs[tabItem.tag];
    NSString *tagId = dic[@"tagId"];
    [self getFoods:tagId];
}

#pragma mark SGAdvertScrollViewDelegate
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    
//    DetailViewController *nextVC = [[DetailViewController alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

// ----------------地图定位-------------------
#pragma mark 地图定位
#pragma mark - Action Handle
- (void)configLocationManager {
    
    self.locationManager = [[TencentLBSLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager setApiKey:@"ZVSBZ-57HCP-3JADY-LK5EG-WTLYK-VDFF2"];
    [self.locationManager setRequestLevel:TencentLBSRequestLevelName];

    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Delegate
-(QAnnotationView *)mapView:(QMapView *)mapView
          viewForAnnotation:(id<QAnnotation>)annotation {
    static NSString *iconReuseIndentifier1 = @"iconReuseIdentifier1";
//    static NSString *iconReuseIndentifier2 = @"iconReuseIndentifier2";
//    static NSString *customReuseIndentifier = @"custReuseIdentifieer";

    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        
        QAnnotationView *annotationView = (QAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:iconReuseIndentifier1];
        if (annotationView == nil) {
            annotationView = [[QAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:iconReuseIndentifier1];
        }
        
        NSString *path = nil;
        if ([annotation.title isEqualToString:@"0"]) {
            path = [[NSBundle mainBundle]
                    pathForResource:@"39@2x"
                    ofType:@"png"];
        }
        else {
            path = [[NSBundle mainBundle]
                    pathForResource:@"40@2x"
                    ofType:@"png"];
        }
        //            annotationView.canShowCallout = YES;
        //设置自定义的图片作为annotation图标
        annotationView.image = [UIImage imageWithContentsOfFile:path];
        //设置图标的锚点为下边缘中心
        //                annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height / 2);
        return annotationView;

//        //添加自定义annotation
//        if ([annotation isEqual:[_annotations objectAtIndex:2]]) {
//            CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndentifier];
//            if (annotationView == nil) {
//                annotationView = [[CustomAnnotationView alloc]
//                                  initWithAnnotation:annotation
//                                  reuseIdentifier:customReuseIndentifier];
//            }
//            NSString *path = [[NSBundle mainBundle]
//                              pathForResource:@"redflag"
//                              ofType:@"png"];
//            UIImage *image = [UIImage imageWithContentsOfFile:path];
//            annotationView.image = image;
//            annotationView.centerOffset = CGPointMake(image.size.width / 2, - image.size.height / 2);
//            NSString *path1 = [[NSBundle mainBundle]
//                               pathForResource:@"tiananmen"
//                               ofType:@"png"];
//            UIImage *image1 = [UIImage imageWithContentsOfFile:path1];
//            [annotationView setCalloutImage:image1];
//            [annotationView setCalloutBtnTitle:@"到这里去"
//                                      forState:UIControlStateNormal];
//            [annotationView addCalloutBtnTarget:self
//                                         action:@selector(calloutButtonAction)
//                               forControlEvents:UIControlEventTouchUpInside];
//            return annotationView;
//        }
    }
    return nil;
}

/*!
 *  @brief  地图区域改变完成时会调用此接口
 *
 *  @param mapView  地图view
 *  @param animated 是否采用动画
 */
- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    if (self.coordinate.latitude) {
        [UIView animateWithDuration:.25 animations:^{
            self.pinView1.top = self.pinView1.top-15;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.25 animations:^{
                self.pinView1.top = (kScreenHeight-kTopHeight-34)/2;
                
            }];
        }];
        self.coordinate = _mapView.centerCoordinate;
        [self getArea];
        
        NSLog(@"latitude：%f,longitude：%f",    _mapView.centerCoordinate.latitude,_mapView.centerCoordinate.longitude);
    }

}

#pragma mark - TencentLBSLocationManagerDelegate

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                 didFailWithError:(NSError *)error {
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位权限未开启，是否开启？" preferredStyle:  UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if( [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]] ) {
#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}completionHandler:^(BOOL success) {
                }];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif
            }
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    } else {
//        [self.displayLabel setText:[NSString stringWithFormat:@"%@", error]];
    }
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                didUpdateLocation:(TencentLBSLocation *)location {
    
    [self.locationManager stopUpdatingLocation];

    self.coordinate = location.location.coordinate;
    
    NSLog(@"latitude：%f,longitude：%f",location.location.coordinate.latitude, location.location.coordinate.longitude);
    [_mapView setCenterCoordinate:location.location.coordinate animated:YES];
    
    [self getArea];

    
//    [self.rightBtn setTitle:location.name forState:UIControlStateNormal];
}



- (void)dealloc
{
    [self.locationManager stopUpdatingLocation];

}

@end
