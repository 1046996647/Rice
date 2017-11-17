//
//  LeftViewController.m
//  CSLeftSlideDemo
//
//  Created by LCS on 16/2/11.
//  Copyright © 2016年 LCS. All rights reserved.
//

#import "LeftViewController.h"
#import "Constants.h"
#import "LeftViewCell.h"

@interface LeftViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewW, kScreenHeight)];
    imgView.image = [UIImage imageNamed:@"Group 3"];
    imgView.clipsToBounds = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgView];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    UIButton *headerBtn = [UIButton buttonWithframe:CGRectMake(95, 76, 75, 75) text:@"" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    headerBtn.layer.cornerRadius = headerBtn.height/2;
    headerBtn.layer.masksToBounds = YES;
    [headerView addSubview:headerBtn];
//    [releseBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headerLab = [UILabel labelWithframe:CGRectMake(headerBtn.center.x-100, headerBtn.bottom+8, 200, 24) text:@"Dayday" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [headerView addSubview:headerLab];
    
    headerView.height = headerLab.bottom+34;
    
    _tableView = [UITableView tableViewWithframe:imgView.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = headerView;

    self.dataArr = @[@{@"image":@"58",@"text":@"我的订单"},
                     @{@"image":@"57",@"text":@"收货地址"},
                     @{@"image":@"56",@"text":@"我的钱包"},
                     @{@"image":@"55",@"text":@"客服"},
                     @{@"image":@"54",@"text":@"设置"}];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 58;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"cell";
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[LeftViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:dic[@"image"]];
    cell.leftLab.text = dic[@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deSelectCell];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(LeftViewControllerdidSelectRow:)]) {
        NSInteger row = indexPath.row;
        [self.delegate LeftViewControllerdidSelectRow:row];
    }
    
}

- (void)deSelectCell
{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

@end
