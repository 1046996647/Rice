//
//  EvaluateCell.m
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EvaluateCell.h"

@implementation EvaluateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 菜品
        _foodImg = [UIImageView imgViewWithframe:CGRectMake(32, 20, 50, 50) icon:@""];
        _foodImg.contentMode = UIViewContentModeScaleAspectFill;
        _foodImg.layer.cornerRadius = _foodImg.height/2;
        _foodImg.layer.masksToBounds = YES;
//        _foodImg.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_foodImg];
        
        
        _foodName = [UILabel labelWithframe:CGRectMake(_foodImg.right+12, _foodImg.center.y-10, kScreenWidth-10-(_foodImg.right+12), 21) text:@"剁椒鸡排饭" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_foodName];
        
        _foodEva = [UILabel labelWithframe:CGRectMake(64, _foodImg.bottom+14, 34, 21) text:@"评分" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_foodEva];
        
        _foodStar = [[StartsView alloc] initWithFrame:CGRectMake(_foodEva.right+21, _foodEva.center.y-15, 0, 30)];
        [_foodStar addSwipeGesture];
        [self.contentView addSubview:_foodStar];
        //    _foodStar.backgroundColor = [UIColor redColor];
        
        __weak typeof(self) weakSelf = self;
        _foodStar.block = ^(NSMutableArray *StartsBtns) {
            
            NSInteger star = 0;
            for (UIButton *btn in StartsBtns) {
                if (!btn.enabled) {
                    star++;
                }
            }
            weakSelf.model.foodStars = [NSString stringWithFormat:@"%ld",star];
        };
        
        
        _foodTV = [[UITextView alloc] initWithFrame:CGRectMake(19, _foodEva.bottom+16, kScreenWidth-38, 152*scaleWidth)];
        _foodTV.layer.cornerRadius = 10;
        _foodTV.layer.masksToBounds = YES;
        _foodTV.font = [UIFont systemFontOfSize:13];
        _foodTV.backgroundColor = colorWithHexStr(@"#FEF9DA");
        [self.contentView addSubview:_foodTV];
        _foodTV.delegate = self;
        _foodTV.tag = 0;
        
        _foodRemind = [UILabel labelWithframe:CGRectMake(16, 8, 200, 16) text:@"点击输入文字评价" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#DDBA7F"];
        [_foodTV addSubview:_foodRemind];
        
    }
    
    
    return self;
}

- (void)setModel:(FoodModel1 *)model
{
    _model = model;
    
    _foodName.text = model.foodName;
    [_foodImg sd_setImageWithURL:[NSURL URLWithString:model.foodImg] placeholderImage:nil];
    _foodTV.text = model.foodComment;
}

/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    _model.foodComment = textView.text;
    if (textView.text.length < 1) {
        self.foodRemind.hidden = NO;
    }
    else {
        self.foodRemind.hidden = YES;
        
    }
    
}


@end
