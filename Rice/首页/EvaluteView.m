//
//  EvaluteView.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EvaluteView.h"
#import "EvaluateVC.h"

@implementation EvaluteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        
        UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 164*scaleWidth, kScreenWidth, 220) icon:@"28"];
        //        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView1];
        imgView1.userInteractionEnabled = YES;
        
        UIButton *cancelBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-30-57+11, 8, 30, 30) text:@"" font:SystemFont(19) textColor:@"#333333" backgroundColor:nil normal:@"27" selected:nil];
        [imgView1 addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];

        
        UILabel *remindLab = [UILabel labelWithframe:CGRectMake(0, imgView1.bottom+ 9, kScreenWidth, 25) text:@"外卖已送达，给个好评嘛!!" font:[UIFont systemFontOfSize:19] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
        [self addSubview:remindLab];
        
        // 评价
        UIButton *evaBtn = [UIButton buttonWithframe:CGRectMake((kScreenWidth-149)/2, remindLab.bottom+35*scaleWidth, 149, 52) text:@"立即评价" font:SystemFont(19) textColor:@"#333333" backgroundColor:nil normal:@"" selected:nil];
        [self addSubview:evaBtn];
        [evaBtn setBackgroundImage:[UIImage imageNamed:@"26"] forState:UIControlStateNormal];
        [evaBtn addTarget:self action:@selector(evaAction) forControlEvents:UIControlEventTouchUpInside];

        

    }
    return self;
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)evaAction
{
    [self removeFromSuperview];
    
    if (self.block) {
        self.block(self.orderId);
    }
}

@end
