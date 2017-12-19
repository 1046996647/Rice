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


@interface BookFoodVC ()<MJCSegmentDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation BookFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titlesArr = @[@"普通商品",@"一周中餐",@"一周晚餐",@"附加品"];
    
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
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    //    [lala intoChildControllerArray:vcarrr];
    lala.delegate  = self;
    lala.backgroundColor = [UIColor clearColor];
    //1.设置阴影颜色
    lala.layer.shadowColor = [UIColor colorWithHexString:@"#CD9435"].CGColor;
    lala.layer.shadowOffset = CGSizeMake(0,.5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    lala.layer.shadowOpacity = 1;//阴影透明度，默认0
    //    self.xiaDanBtn.layer.shadowRadius = 2;//阴影半径，默认3
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, lala.bottom, kScreenWidth, kScreenHeight-kTopHeight-lala.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArr.count;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 244;
    
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
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
