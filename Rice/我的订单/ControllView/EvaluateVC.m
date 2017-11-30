//
//  EvaluateVC.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EvaluateVC.h"
#import "StartsView.h"


@interface EvaluateVC ()<UITextViewDelegate>

@property(nonatomic,strong) UIImageView *foodImg;
@property(nonatomic,strong) UILabel *foodName;
@property(nonatomic,strong) UILabel *foodEva;
@property(nonatomic,strong) UILabel *foodRemind;
@property(nonatomic,strong) UITextView *foodTV;
@property(nonatomic,strong) StartsView *foodStar;

@property(nonatomic,strong) UIImageView *horsemanImg;
@property(nonatomic,strong) UILabel *horsemanName;
@property(nonatomic,strong) UILabel *horsemanEva;
@property(nonatomic,strong) UILabel *horsemanRemind;
@property(nonatomic,strong) UITextView *horsemanTV;
@property(nonatomic,strong) StartsView *horsemanStar;

@end

@implementation EvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 36, 22) text:@"提交" font:SystemFont(16) textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    //    [viewBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewBtn];
    
    // 菜品
    _foodImg = [UIImageView imgViewWithframe:CGRectMake(32, 20, 50, 50) icon:@""];
    _foodImg.contentMode = UIViewContentModeScaleAspectFill;
    _foodImg.layer.cornerRadius = _foodImg.height/2;
    _foodImg.layer.masksToBounds = YES;
    _foodImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:_foodImg];
    
    
    _foodName = [UILabel labelWithframe:CGRectMake(_foodImg.right+12, _foodImg.center.y-10, kScreenWidth-10-(_foodImg.right+12), 21) text:@"剁椒鸡排饭" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [self.view addSubview:_foodName];
    
    _foodEva = [UILabel labelWithframe:CGRectMake(64, _foodImg.bottom+14, 34, 21) text:@"评分" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [self.view addSubview:_foodEva];
    
    _foodStar = [[StartsView alloc] initWithFrame:CGRectMake(_foodEva.right+21, _foodEva.center.y-15, 0, 30)];
    [_foodStar addSwipeGesture];
    [self.view addSubview:_foodStar];
//    _foodStar.backgroundColor = [UIColor redColor];

    
    _foodTV = [[UITextView alloc] initWithFrame:CGRectMake(19, _foodEva.bottom+16, kScreenWidth-38, 152*scaleWidth)];
    _foodTV.layer.cornerRadius = 10;
    _foodTV.layer.masksToBounds = YES;
    _foodTV.font = [UIFont systemFontOfSize:13];
    _foodTV.backgroundColor = colorWithHexStr(@"#FEF9DA");
    [self.view addSubview:_foodTV];
    _foodTV.delegate = self;
    _foodTV.tag = 0;
    
    _foodRemind = [UILabel labelWithframe:CGRectMake(16, 8, 200, 16) text:@"点击输入文字评价" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#DDBA7F"];
    [_foodTV addSubview:_foodRemind];
    
    // 骑手
    _horsemanImg = [UIImageView imgViewWithframe:CGRectMake(32, _foodTV.bottom+24, 50, 50) icon:@""];
    _horsemanImg.contentMode = UIViewContentModeScaleAspectFill;
    _horsemanImg.layer.cornerRadius = _foodImg.height/2;
    _horsemanImg.layer.masksToBounds = YES;
    _horsemanImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:_horsemanImg];


    _horsemanName = [UILabel labelWithframe:CGRectMake(_horsemanImg.right+12, _horsemanImg.center.y-10, kScreenWidth-10-(_horsemanImg.right+12), 21) text:@"骑手：蔡晓明" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [self.view addSubview:_horsemanName];

    _horsemanEva = [UILabel labelWithframe:CGRectMake(64, _horsemanImg.bottom+14, 34, 21) text:@"评分" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [self.view addSubview:_horsemanEva];

    _horsemanStar = [[StartsView alloc] initWithFrame:CGRectMake(_horsemanEva.right+21, _horsemanEva.center.y-15, _foodStar.width, 30)];
    [_horsemanStar addSwipeGesture];
    [self.view addSubview:_horsemanStar];
    //    _foodStar.backgroundColor = [UIColor redColor];


    _horsemanTV = [[UITextView alloc] initWithFrame:CGRectMake(19, _horsemanEva.bottom+16, kScreenWidth-38, 152*scaleWidth)];
    _horsemanTV.layer.cornerRadius = 10;
    _horsemanTV.layer.masksToBounds = YES;
    _horsemanTV.font = [UIFont systemFontOfSize:13];
    _horsemanTV.backgroundColor = colorWithHexStr(@"#FEF9DA");
    [self.view addSubview:_horsemanTV];
    _horsemanTV.delegate = self;
    _horsemanTV.tag = 1;

    _horsemanRemind = [UILabel labelWithframe:CGRectMake(16, 8, 200, 16) text:@"点击输入文字评价" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#DDBA7F"];
    [_horsemanTV addSubview:_horsemanRemind];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == 0) {
        if (textView.text.length < 1) {
            self.foodRemind.hidden = NO;
        }
        else {
            self.foodRemind.hidden = YES;
            
        }
    }
    else {
        if (textView.text.length < 1) {
            self.horsemanRemind.hidden = NO;
        }
        else {
            self.horsemanRemind.hidden = YES;
            
        }
    }

}

@end
