//
//  SettingVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "PersonalCenterVC.h"
#import "CountBindingVC.h"
#import "ModifyPasswordVC.h"

@interface SettingVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(34, 70, kScreenWidth-68, 42) text:@"退出账号" font:[UIFont systemFontOfSize:16] textColor:@"#333333" backgroundColor:@"#FFF0B0" normal:nil selected:nil];
    exitBtn.layer.cornerRadius = 7;
    exitBtn.layer.masksToBounds = YES;
    [footerView addSubview:exitBtn];
    [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];

    
    footerView.height = exitBtn.bottom;
//    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView = footerView;
    
    self.dataArr = @[@"个人信息",@"社交账号绑定",@"修改密码",@"关于我们"
                     ];
}

- (void)exitAction:(UIButton *)btn
{
    [InfoCache archiveObject:nil toFile:Person];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    if (indexPath.row == self.dataArr.count-1) {
        cell.line.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.row == 0) {
        
        PersonalCenterVC *vc = [[PersonalCenterVC alloc] init];
        vc.title = @"个人信息";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        
        CountBindingVC *vc = [[CountBindingVC alloc] init];
        vc.title = @"社交账号绑定";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.row == 2) {
        
        ModifyPasswordVC *vc = [[ModifyPasswordVC alloc] init];
        vc.title = @"修改密码";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.row == 3) {
        
//        CountBindingVC *vc = [[CountBindingVC alloc] init];
//        vc.title = @"社交账号绑定";
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


@end
