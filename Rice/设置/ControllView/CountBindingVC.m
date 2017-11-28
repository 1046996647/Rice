//
//  CountBindingVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CountBindingVC.h"

@interface CountBindingVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *imgArr;

@end

@implementation CountBindingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 10, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataArr = @[@"已绑定",@"未绑定"
                     ];
    
    self.imgArr = @[@"50",@"48"
                     ];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                  reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, 9, 15) icon:@"Back Chevron Copy 2"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryView = imgView;
    }
    if (indexPath.row != self.dataArr.count-1) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(21, 56-1, kScreenWidth-21*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#F8E249"];
        [cell.contentView addSubview:line];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.detailTextLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        
//        PersonalCenterVC *vc = [[PersonalCenterVC alloc] init];
//        vc.title = @"个人信息";
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        
        //        InfoChangeController *vc = [[InfoChangeController alloc] init];
        //        vc.title = @"名字";
        //        vc.text = cell.detailTextLabel.text;
        //        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
