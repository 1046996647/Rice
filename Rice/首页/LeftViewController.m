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
#import "MyOrderVC.h"
#import "ReceiveAddressVC.h"
#import "MyWalletVC.h"
#import "ServiceVC.h"
#import "SettingVC.h"
#import "PersonalCenterVC.h"


@interface LeftViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UILabel *headerLab;
@property (nonatomic, strong) UIButton *headerBtn;
@property(nonatomic,strong) UIView *redDot;


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
    
    UIButton *headerBtn = [UIButton buttonWithframe:CGRectMake(95, 76, 75, 75) text:@"" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:nil normal:@"" selected:nil];
    headerBtn.layer.cornerRadius = headerBtn.height/2;
    headerBtn.layer.masksToBounds = YES;
    [headerView addSubview:headerBtn];
    [headerBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    self.headerBtn = headerBtn;

    
    // Dayday
    UILabel *headerLab = [UILabel labelWithframe:CGRectMake(headerBtn.center.x-100, headerBtn.bottom+8, 200, 24) text:@"" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [headerView addSubview:headerLab];
    self.headerLab = headerLab;
    
    headerView.height = headerLab.bottom+10;
    
    _tableView = [UITableView tableViewWithframe:imgView.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = headerView;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(15, kStatusBarHeight+8.5, 33, 33)];
    [self.view addSubview:leftView];
    
    UIButton *leftBtn = [UIButton buttonWithframe:leftView.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:@"消息" selected:@""];
    [leftView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    _redDot = [[UIView alloc] initWithFrame:CGRectMake(leftView.width-4-4, 4, 8, 8)];
    _redDot.layer.cornerRadius = _redDot.height/2;
    _redDot.layer.masksToBounds = YES;
    _redDot.backgroundColor = [UIColor redColor];
    [leftView addSubview:_redDot];
    _redDot.hidden = YES;

    self.dataArr = @[@{@"image":@"58",@"text":@"我的订单"},
                     @{@"image":@"57",@"text":@"收货地址"},
                     @{@"image":@"56",@"text":@"我的钱包"},
                     @{@"image":@"55",@"text":@"客服"},
                     @{@"image":@"54",@"text":@"设置"}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMsg) name:@"kRefreshNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redDotAction) name:@"kRedDotNotification" object:nil];
    
    [self setMsg];
    [self redDotAction];

}

- (void)redDotAction
{
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:IsUserClicked dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        BOOL obj = [responseObject[@"data"][@"isClicked"] boolValue];
        if (obj) {
            _redDot.hidden = YES;
        }
        else {
            _redDot.hidden = NO;

        }
        
    } failure:^(NSError *error) {
        
        
    }];

}

- (void)leftAction
{
    [self.delegate LeftViewControllerdidSelectRow:6];

    
}

- (void)headAction
{
    [self.delegate LeftViewControllerdidSelectRow:5];


}

- (void)setMsg
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:model.headImg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Group 5-1"]];
    if (model.name.length > 0) {
        self.headerLab.text = model.name;
        
    }
    else {
        self.headerLab.text = @"未设置";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

- (void)setPersonModel:(PersonModel *)personModel
{
    _personModel = personModel;
    
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:personModel.headImg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Group 5-1"]];

    
    if (personModel.name) {
        self.headerLab.text = personModel.name;

    }
    else {
        self.headerLab.text = @"未设置";
    }
}



@end
