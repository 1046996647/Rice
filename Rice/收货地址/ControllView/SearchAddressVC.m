//
//  SearchAddressVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/5.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchAddressVC.h"
#import <QMapKit/QMapKit.h>
#import <TencentLBS/TencentLBS.h>
#import "NearbyAddressCell.h"
#import "SearchResultVC.h"


@interface SearchAddressVC ()<QMapViewDelegate,TencentLBSLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITextField *addTF;
@property(nonatomic,strong) UITextField *detailTF;
@property(nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) NSArray *dataArr;

// 地图
@property (nonatomic, strong) QMapView *mapView;
@property (readwrite, nonatomic, strong) TencentLBSLocationManager *locationManager;
@property (nonatomic, strong) TencentLBSLocation *location;

@end

@implementation SearchAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor redColor];
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    baseView.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
    [self.view addSubview:baseView];
    
    // 杭州
    UIButton *addBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 70, baseView.height) text:@"" font:SystemFont(14) textColor:@"#333333" backgroundColor:nil normal:@"定位" selected:nil];
    //    _viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [baseView addSubview:addBtn];
    self.addBtn = addBtn;
    
    //    CGFloat wdith = (kScreenWidth-10-70)/2;
    
    // 搜索框
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, leftView1.width, 16) icon:@"15"];
    imgView0.contentMode = UIViewContentModeScaleAspectFit;
    imgView0.center = leftView1.center;
    
    [leftView1 addSubview:imgView0];
    
    _addTF = [UITextField textFieldWithframe:CGRectMake(75, (baseView.height-30)/2, kScreenWidth-20-75, 30) placeholder:@"查找写字楼等" font:[UIFont systemFontOfSize:14] leftView:leftView1 backgroundColor:@"#FFFFFF"];
    [_addTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_addTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _addTF.layer.cornerRadius = _addTF.height/2;
    _addTF.layer.masksToBounds = YES;
    //    _addTF.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:_addTF];
    _addTF.text = @"";
    
    // 替代
    UIButton *addTFBtn = [UIButton buttonWithframe:_addTF.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:nil selected:nil];
    [_addTF addSubview:addTFBtn];
    [addTFBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 地图mapview(不知为什么地图下边填充64)
    _mapView = [[QMapView alloc] initWithFrame:CGRectMake(0,
                                                          baseView.bottom,
                                                          kScreenWidth,
                                                          300*scaleWidth+64)];
    _mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [_mapView setZoomLevel:15.01];
//    _mapView.showsUserLocation = YES;// 默认是NO

    
    
    [self configLocationManager];
    [self startUpdatingLocation];

    
    // 去掉logo
    for (UIView *view in _mapView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
    
    // 定位图片
    UIButton *locationBtn = [UIButton buttonWithframe:CGRectMake(7, _mapView.height-31-7-64, 31, 31) text:nil font:nil textColor:nil backgroundColor:nil normal:@"13" selected:nil];
    [_mapView addSubview:locationBtn];
    [locationBtn addTarget:self action:@selector(startUpdatingLocation) forControlEvents:UIControlEventTouchUpInside];
    
    // 表视图
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, _mapView.bottom-64, kScreenWidth, kScreenHeight-kTopHeight-_mapView.bottom+64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    _tableView.backgroundColor = [UIColor redColor];

//
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 22)];

    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"保存" font:SystemFont(17) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [rightView addSubview:viewBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [viewBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)saveAction
{
    //    NSString *address = [NSString stringWithFormat:@"%@%@%@",self.addBtn.currentTitle, self.addTF.text, self.detailTF.text];
//    NSString *address = [NSString stringWithFormat:@"%@%@",self.addBtn.currentTitle, self.addTF.text];
    
    if (self.block) {
        if (self.addTF.text) {
       
            NSString *lat = [NSString stringWithFormat:@"%f",self.location.location.coordinate.latitude];
            NSString *lng = [NSString stringWithFormat:@"%f",self.location.location.coordinate.longitude];
            self.block(self.addTF.text,lat,lng);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction
{
    SearchResultVC *vc = [[SearchResultVC alloc] init];
    vc.lBSLocation = self.location;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *text) {
        
        self.addTF.text = text;
    };
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
    [self.locationManager setRequestLevel:TencentLBSRequestLevelPoi];
    
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
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
    
    // 定位
    [self.addBtn setTitle:location.city forState:UIControlStateNormal];
    NSMutableArray *arrM = [NSMutableArray array];
    for (TencentLBSPoi *poiInfo in location.poiList) {
        [arrM addObject:poiInfo];
    }
    self.dataArr = arrM;
    [_tableView reloadData];
    
    self.location = location;
//    [self getTags];
    
    NSLog(@"latitude：%f,longitude：%f",location.location.coordinate.latitude, location.location.coordinate.longitude);
    [_mapView setCenterCoordinate:location.location.coordinate animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TencentLBSPoi *poiInfo = self.dataArr[indexPath.row];
    self.addTF.text = poiInfo.name;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearbyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[NearbyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    TencentLBSPoi *poiInfo = self.dataArr[indexPath.row];
    cell.textLab.text = poiInfo.name;
    cell.detailLab.text = poiInfo.address;
    
    return cell;
}

- (void)dealloc
{
    [self.locationManager stopUpdatingLocation];
    
}

@end
