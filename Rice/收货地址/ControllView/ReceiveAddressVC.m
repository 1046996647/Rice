//
//  ReceiveAddressVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReceiveAddressVC.h"
#import "ReceiveAddressCell.h"
#import "AddAddressVC.h"

@interface ReceiveAddressVC ()

<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *titleLab;

//@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组
//@property(nonatomic,strong) NSMutableArray *orderArr;// 排序数组
//@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation ReceiveAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 64, kScreenWidth, 200) icon:@"19"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *titleLab = [UILabel labelWithframe:CGRectMake(0, imgView.bottom+25, kScreenWidth, 20) text:@"您没有增加收货地址哦~" font:[UIFont systemFontOfSize:20] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
    [self.view addSubview:titleLab];
    self.titleLab = titleLab;

    self.titleLab.hidden = YES;
    self.imgView.hidden = YES;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-45) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *addBtn = [UIButton buttonWithframe:CGRectMake(0, _tableView.bottom, kScreenWidth, 45) text:@"  新增地址" font:SystemFont(17) textColor:@"#333333" backgroundColor:@"#F8E249" normal:@"17" selected:@""];
    [self.view addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)getAddress
{
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];

    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetAddress dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {

            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                
                NSMutableArray *arrM1 = [NSMutableArray array];
                AddAddressModel *model = [AddAddressModel yy_modelWithJSON:dic];
                [arrM1 addObject:model];
                [arrM addObject:arrM1];
            }
            self.dataArr = arrM;
            [_tableView reloadData];
            
            if (arr.count > 0) {
                self.titleLab.hidden = YES;
                self.imgView.hidden = YES;
            }
            else {
                self.titleLab.hidden = NO;
                self.imgView.hidden = NO;
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAddress];
}

- (void)addAction
{
    AddAddressVC *vc = [[AddAddressVC alloc] init];
    vc.title = @"新增地址";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
//        return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
//        return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddAddressModel *model = self.dataArr[indexPath.section][indexPath.row];
    
    AddAddressVC *vc = [[AddAddressVC alloc] init];
    vc.title = @"修改地址";
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexpath {
    
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    AddAddressModel *model = self.dataArr[indexPath.section][indexPath.row];

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:model.addressId forKey:@"addressId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:DeleteAddress dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self getAddress];

    } failure:^(NSError *error) {
        
        
    }];
//    [self.dataArr removeObjectAtIndex:indexPath.section];
//    [_tableView reloadData];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;// 为0无效

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identity = @"FDFeedCell";
    
    ReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        
        cell = [[ReceiveAddressCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identity];
        cell.block = ^{
            [self getAddress];
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    AddAddressModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
//    cell.dataArr = _dataArr;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
