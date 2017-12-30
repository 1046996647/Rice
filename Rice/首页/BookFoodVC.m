//
//  BookFoodVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BookFoodVC.h"
#import "MJCSegmentInterface.h"
#import "BookCell.h"

#import<WebKit/WebKit.h>

@interface BookFoodVC ()<MJCSegmentDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) MJCSegmentInterface *lala;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *tagArrs;// 标签数组
@property (nonatomic, strong) NSString *tagId;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,assign) CGFloat y;
@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation BookFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSArray *titlesArr = @[@"普通商品",@"一周中餐",@"一周晚餐",@"附加品"];

    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.titleBarStyles = MJCTitlesScrollStyle;
    lala.frame = CGRectMake(0, 0, kScreenWidth, 37);// 内容视图大小
    lala.titlesViewFrame = lala.bounds;// 标题栏大小
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
//    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    //    [lala intoChildControllerArray:vcarrr];
    lala.delegate  = self;
    lala.backgroundColor = [UIColor clearColor];
    //1.设置阴影颜色
    lala.layer.shadowColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
    lala.layer.shadowOffset = CGSizeMake(0,.5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    lala.layer.shadowOpacity = 1;//阴影透明度，默认0
    //    self.xiaDanBtn.layer.shadowRadius = 2;//阴影半径，默认3
    self.lala = lala;

    _tableView = [UITableView tableViewWithframe:CGRectMake(0, lala.bottom, kScreenWidth, kScreenHeight-kTopHeight-lala.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor = [UIColor redColor];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        if (self.dataArr.count > 0) {

            [self getFoods:self.tagId];
        }

    }];
    
    
    self.pageNO = 1;
    self.dataArr = [NSMutableArray array];
    
    [self getReserveTags];
    
}


// 获取标签
- (void)getReserveTags
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetReserveTags dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        self.tagArrs = arr;

        NSMutableArray *tagArr = [NSMutableArray array];

        for (NSDictionary *dic in arr) {
            [tagArr addObject:dic[@"tagName"]];
        }
        [self.lala intoTitlesArray:tagArr hostController:self];
        
        // 取出第一个tagId
        NSDictionary *dic = [arr firstObject];
        NSString *tagId = dic[@"tagId"];
        self.tagId = tagId;
        
        [self getFoods:tagId];
        
        
    } failure:^(NSError *error) {
        
    }];
}

// 2.10    根据标签获取预定菜品
- (void)getFoods:(NSString *)tagId
{
    
    if (!self.isRefresh) {
        [SVProgressHUD show];

    }
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic setValue:@(self.pageNO) forKey:@"pageIndex"];
    [paramDic  setValue:tagId forKey:@"tagId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetReserveFoods dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        //        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        
        id obj = responseObject[@"data"];
        
        if ([obj count]) {
            NSMutableArray *foodArr = [NSMutableArray array];
            for (NSDictionary *dic in obj) {
                FoodModel *model = [FoodModel yy_modelWithJSON:dic];
                [foodArr addObject:model];
                
            }
            [self.dataArr addObjectsFromArray:foodArr];
            self.pageNO++;
            
            [_tableView reloadData];
        
        }
        
        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

        
        
    } failure:^(NSError *error) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
//        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
//    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 244;
//    return 44;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"cell";
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];

    }
    
    if (self.dataArr.count > 0) {
        cell.model = self.dataArr[indexPath.row];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark MJCSegmentDelegate
- (void)mjc_ClickEvent:(UIButton *)tabItem childViewController:(UIViewController *)childViewController segmentInterface:(MJCSegmentInterface *)segmentInterface
{
    //    _tag = tabItem.tag;
    NSLog(@"%ld",tabItem.tag);
    
    self.pageNO = 1;
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
        
    }
    [_tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    NSDictionary *dic = self.tagArrs[tabItem.tag];
    NSString *tagId = dic[@"tagId"];
    self.tagId = tagId;

    [self getFoods:tagId];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
//    self.y = scrollView.contentOffset.y;
}

@end
