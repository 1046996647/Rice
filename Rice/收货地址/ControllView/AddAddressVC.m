//
//  AddAddressVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AddAddressVC.h"
#import "AddAddressCell.h"

@interface AddAddressVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
//@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组
//@property(nonatomic,strong) NSMutableArray *orderArr;// 排序数组

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@{@"leftTitle":@"  姓名：",@"rightTitle":@"请填写收货人的姓名",@"text":@"",@"key":@"title"},
                     @{@"leftTitle":@"  电话：",@"rightTitle":@"请填写收货手机号码",@"text":@"",@"key":@"cateName"},
                     @{@"leftTitle":@"  收货地址：",@"rightTitle":@"请选择收货地址",@"text":@"",@"key":@"tag"},
                     @{@"leftTitle":@"  门牌号：",@"rightTitle":@"请填写楼牌号",@"text":@"",@"key":@"tag"}
                     ];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArr) {
        
        AddAddressModel *model = [AddAddressModel yy_modelWithJSON:dic];
        [arrM addObject:model];
    }
    
    self.dataArr = arrM;
    [_tableView reloadData];
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(0, 0, kScreenWidth, 30) text:@"      收货人" font:SystemFont(13) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 56+42)];
    
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(34, 36, kScreenWidth-68, 42) text:@"保存" font:[UIFont systemFontOfSize:16] textColor:@"#ffffff" backgroundColor:@"#F8E249" normal:nil selected:nil];
    exitBtn.layer.cornerRadius = 7;
    exitBtn.layer.masksToBounds = YES;
    [footerView addSubview:exitBtn];
    
//    footerView.height = exitBtn.bottom;
    
    _tableView.tableHeaderView = nameLab;
    _tableView.tableFooterView = footerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
//    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identity = @"FDFeedCell";
    
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        
        cell = [[AddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:identity];
        
    }
    if (indexPath.row == self.dataArr.count-1) {
        cell.line.hidden = YES;
    }
    else {
        cell.line.hidden = NO;

    }
    AddAddressModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

@end
