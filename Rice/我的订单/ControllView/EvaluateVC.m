//
//  EvaluateVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EvaluateVC.h"
#import "StartsView.h"
#import "EvaluateCell.h"


@interface EvaluateVC ()<UITextViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@property(nonatomic,strong) UIImageView *horsemanImg;
@property(nonatomic,strong) UILabel *horsemanName;
@property(nonatomic,strong) UILabel *horsemanEva;
@property(nonatomic,strong) UILabel *horsemanRemind;
@property(nonatomic,strong) UITextView *horsemanTV;
@property(nonatomic,strong) StartsView *horsemanStar;
@property(nonatomic,strong) NSString *riderStars;

@end

@implementation EvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 36, 22) text:@"提交" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [viewBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    // 骑手
    _horsemanImg = [UIImageView imgViewWithframe:CGRectMake(32, 24, 50, 50) icon:@"rider"];
    _horsemanImg.contentMode = UIViewContentModeScaleAspectFill;
    _horsemanImg.layer.cornerRadius = 50/2;
    _horsemanImg.layer.masksToBounds = YES;
//    _horsemanImg.backgroundColor = [UIColor redColor];
    [footerView addSubview:_horsemanImg];


    // 骑手：蔡晓明
    _horsemanName = [UILabel labelWithframe:CGRectMake(_horsemanImg.right+12, _horsemanImg.center.y-10, kScreenWidth-10-(_horsemanImg.right+12), 21) text:@"" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [footerView addSubview:_horsemanName];

    _horsemanEva = [UILabel labelWithframe:CGRectMake(64, _horsemanImg.bottom+14, 34, 21) text:@"评分" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [footerView addSubview:_horsemanEva];

    _horsemanStar = [[StartsView alloc] initWithFrame:CGRectMake(_horsemanEva.right+21, _horsemanEva.center.y-15, 0, 30)];
    [_horsemanStar addSwipeGesture];
    [footerView addSubview:_horsemanStar];
    //    _foodStar.backgroundColor = [UIColor redColor];
    __weak typeof(self) weakSelf = self;
    _horsemanStar.block = ^(NSMutableArray *StartsBtns) {
        
        NSInteger star = 0;
        for (UIButton *btn in StartsBtns) {
            if (!btn.enabled) {
                star++;
            }
        }
        weakSelf.riderStars = [NSString stringWithFormat:@"%ld",star];
    };
    self.riderStars = @"1";


    _horsemanTV = [[UITextView alloc] initWithFrame:CGRectMake(19, _horsemanEva.bottom+16, kScreenWidth-38, 152*scaleWidth)];
    _horsemanTV.layer.cornerRadius = 10;
    _horsemanTV.layer.masksToBounds = YES;
    _horsemanTV.font = [UIFont systemFontOfSize:13];
    _horsemanTV.backgroundColor = colorWithHexStr(@"#FEF9DA");
    [footerView addSubview:_horsemanTV];
    _horsemanTV.delegate = self;
    _horsemanTV.tag = 1;

    _horsemanRemind = [UILabel labelWithframe:CGRectMake(16, 8, 200, 16) text:@"点击输入文字评价" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#DDBA7F"];
    [_horsemanTV addSubview:_horsemanRemind];
    
    footerView.height = _horsemanTV.bottom;
    _tableView.tableFooterView = footerView;
    
    [self toCommentPage];
    
    
}

- (void)upAction
{
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (FoodModel1 *model in self.dataArr) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.foodId,@"foodId", model.foodStars,@"foodStars",model.foodComment,@"foodComment", nil];
        [arrM addObject:paramDic];
        
    }
    NSString *jsonStr = [NSString JSONString:arrM];
    [paramDic setValue:jsonStr forKey:@"listFoodComments"];
    [paramDic setValue:self.riderStars forKey:@"riderStars"];
    [paramDic setValue:_horsemanTV.text forKey:@"riderComment"];
    [paramDic setValue:self.orderId forKey:@"orderId"];

    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:AddComment dic:paramDic showHUD:YES response:YES Succed:^(id responseObject) {
        

        if (self.block) {
            self.block();
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)toCommentPage
{

    
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic setValue:self.orderId forKey:@"orderId"];

    [AFNetworking_RequestData requestMethodPOSTUrl:ToCommentPage dic:paramDic showHUD:YES response:YES Succed:^(id responseObject) {
        
        id obj = responseObject[@"data"];
        PayMentModel *model = [PayMentModel yy_modelWithJSON:obj];
        
        _horsemanName.text = [NSString stringWithFormat:@"骑手：%@",model.riderName];

        for (FoodModel1 *foodModel in model.listFoods) {
            foodModel.foodComment = @"";
            foodModel.foodStars = @"1";

        }
        self.dataArr = model.listFoods;
        [_tableView reloadData];
        
    } failure:^(NSError *error) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
//        return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (153+118);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cell_id = @"cell";
    EvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[EvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    cell.model = _dataArr[indexPath.row];

    return cell;
}

/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length < 1) {
        self.horsemanRemind.hidden = NO;
    }
    else {
        self.horsemanRemind.hidden = YES;
        
    }

}

@end
