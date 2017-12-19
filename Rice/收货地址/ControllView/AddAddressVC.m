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
    
    if (self.model) {
        self.dataArr = @[@{@"leftTitle":@"  姓名：",@"rightTitle":@"请填写收货人的姓名",@"text":self.model.name,@"key":@"name"},
                         @{@"leftTitle":@"  电话：",@"rightTitle":@"请填写收货手机号码",@"text":self.model.phone,@"key":@"phone"},
                         @{@"leftTitle":@"  收货地址：",@"rightTitle":@"请选择收货地址",@"text":self.model.address,@"lat":self.model.lat,@"lng":self.model.lng,@"key":@"address"},
                         @{@"leftTitle":@"  门牌号：",@"rightTitle":@"请填写楼牌号",@"text":self.model.detail,@"key":@"detail"}
                         ];
    }
    else {
        self.dataArr = @[@{@"leftTitle":@"  姓名：",@"rightTitle":@"请填写收货人的姓名",@"text":@"",@"key":@"name"},
                         @{@"leftTitle":@"  电话：",@"rightTitle":@"请填写收货手机号码",@"text":@"",@"key":@"phone"},
                         @{@"leftTitle":@"  收货地址：",@"rightTitle":@"请选择收货地址",@"text":@"",@"key":@"address"},
                         @{@"leftTitle":@"  门牌号：",@"rightTitle":@"请填写楼牌号",@"text":@"",@"key":@"detail"}
                         ];
    }

    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArr) {
        
        UserAddressModel *model = [UserAddressModel yy_modelWithJSON:dic];
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
    [exitBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];

    
//    footerView.height = exitBtn.bottom;
    
    _tableView.tableHeaderView = nameLab;
    _tableView.tableFooterView = footerView;
}

- (void)saveAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];

    for (UserAddressModel *model in self.dataArr) {
        
        if (model.text.length == 0) {
            [self.view makeToast:@"请完善地址信息"];
            return;
        }
        
        [paramDic setValue:model.text forKey:model.key];
        if (model.lat) {
            [paramDic setValue:model.lat forKey:@"lat"];
            [paramDic setValue:model.lng forKey:@"lng"];
        }

    }
    
    NSString *urlStr = nil;
    if ([self.title isEqualToString:@"修改地址"]) {
        urlStr = UpdateAddress;
        [paramDic setValue:self.model.addressId forKey:@"addressId"];
        [paramDic setValue:self.model.lat forKey:@"lat"];
        [paramDic setValue:self.model.lng forKey:@"lng"];
    }
    else {
        urlStr = AddAddress;
    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];

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
    UserAddressModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

@end
