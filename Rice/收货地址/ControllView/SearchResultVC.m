//
//  SearchResultVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/5.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchResultVC.h"
#import <QMapSearchKit/QMapSearchKit.h>
#import "NearbyAddressCell.h"


@interface SearchResultVC ()<QMSSearchDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) QMSSearcher *searcher;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UITextField *addTF;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation SearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    baseView.backgroundColor = colorWithHexStr(@"#F8E249");
    [self.view addSubview:baseView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    button.frame = CGRectMake(17, kStatusBarHeight+(kNavBarHeight-20)/2, 30, 20);
    //        button.backgroundColor = [UIColor greenColor]
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:button];
    
    // 搜索框
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, leftView1.width, 16) icon:@"15"];
    imgView0.contentMode = UIViewContentModeScaleAspectFit;
    imgView0.center = leftView1.center;
    
    [leftView1 addSubview:imgView0];
    
    _addTF = [UITextField textFieldWithframe:CGRectMake(40, kStatusBarHeight+(kNavBarHeight-30)/2, kScreenWidth-40-54, 30) placeholder:@"查找写字楼等" font:[UIFont systemFontOfSize:14] leftView:leftView1 backgroundColor:@"#FFFFFF"];
    [_addTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_addTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _addTF.layer.cornerRadius = _addTF.height/2;
    _addTF.layer.masksToBounds = YES;
    [baseView addSubview:_addTF];
    _addTF.delegate = self;
    _addTF.returnKeyType = UIReturnKeySearch;
    
    
//    // 右上角按钮
//    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(_addTF.right, _addTF.center.y-6.5, 54, 17) text:@"搜索" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:nil selected:nil];
//    [baseView addSubview:viewBtn];
    
    // 表视图
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, baseView.bottom, kScreenWidth, kScreenHeight-baseView.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //初始化搜索
    self.searcher = [[QMSSearcher alloc] init];
    [self.searcher setDelegate:self];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
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
    
    QMSPoiData *poiInfo = self.dataArr[indexPath.row];
    if (self.block) {
        self.block(poiInfo.title);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearbyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[NearbyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    QMSPoiData *poiInfo = self.dataArr[indexPath.row];
    cell.textLab.text = poiInfo.title;
    cell.detailLab.text = poiInfo.address;
    
    return cell;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [textField resignFirstResponder];
        
        return YES;
    }
    
    [textField resignFirstResponder];
    
    [SVProgressHUD show];
    
    QMSPoiSearchOption *poiSearchOption = [[QMSPoiSearchOption alloc] init];
//    //地区检索
    [poiSearchOption setBoundaryByRegionWithCityName:self.lBSLocation.city autoExtend:NO];
    //周边检索
//    [poiSearchOption setBoundaryByNearbyWithCenterCoordinate:self.lBSLocation.location.coordinate radius:1000];
    //矩形检索
    //[poiSearchOption setBoundaryByRectangleWithleftBottomCoordinate:
    //CLLocationCoordinate2DMake(39, 116) rightTopCoordinate:
    //CLLocationCoordinate2DMake(40, 117)];
    //设置检索分类
//    [poiSearchOption setFilter:@"category=美食"];
    [poiSearchOption setKeyword:textField.text];
    [self.searcher searchWithPoiSearchOption:poiSearchOption];
    
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 当发起检索后，可以通过如下回调函数获取检索结果
//查询出现错误
- (void)searchWithSearchOption:(QMSSearchOption *)searchOption
              didFailWithError:(NSError*)error
{
    NSLog(@"搜索失败");
    [SVProgressHUD dismiss];
}

//poi查询结果回调函数
- (void)searchWithPoiSearchOption:(QMSPoiSearchOption *)poiSearchOption
                 didReceiveResult:(QMSPoiSearchResult *)poiSearchResult
{
    NSLog(@"搜索成功");
    [SVProgressHUD dismiss];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    //poi列表
    for (QMSPoiData *info in poiSearchResult.dataArray) {
        
        [arrM addObject:info];
        
    }
    self.dataArr = arrM;
    [self.tableView reloadData];
}

@end
