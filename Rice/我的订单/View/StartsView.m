//
//  StartsView.m
//  StartsTest
//
//  Created by 李聪会 on 2016/10/11.
//  Copyright © 2016年 李聪会. All rights reserved.
//

#import "StartsView.h"
@interface StartsView()


@end

@implementation StartsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.panView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.panView];
        
        self.StartsBtns = [NSMutableArray array];
        
        for (int i=0; i<5; i++) {
            
            UIButton *button = [UIButton buttonWithframe:CGRectMake(i*(self.height+10), 0, self.height, self.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"29" selected:@"30"];
            [button setImage:[UIImage imageNamed:@"30"] forState:UIControlStateDisabled];
            button.userInteractionEnabled = NO;

            [self.panView addSubview:button];
            [self.StartsBtns addObject:button];
            
            if (i == 0) {
                button.enabled = NO;
            }
            
        }
        
    }
    return self;
}

- (void)addSwipeGesture
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.panView addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapPan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.panView addGestureRecognizer:tapPan];
}

//轻扫手势触发方法
-(void)panGesture:(id)sender
{
    UIPanGestureRecognizer *pan = sender;
    CGPoint point = [pan locationInView:self];
   
    if (pan.state== UIGestureRecognizerStateBegan )
    {
       
    }else if (pan.state== UIGestureRecognizerStateEnded)
    {
       
    }else
    {
        [self.StartsBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = obj;
            
            if (btn.frame.origin.x<=point.x) {
                btn.enabled = NO;
            }else
            {
                btn.enabled = YES;
            }
        }];
   
    }
    UIButton *btn = self.StartsBtns[0];
    btn.enabled = NO;
    
}
-(void)tapGesture:(id)sender
{
    UITapGestureRecognizer *pan = sender;
        CGPoint point = [pan locationInView:self];
        [self.StartsBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = obj;
            if (btn.frame.origin.x<point.x) {
                btn.enabled = NO;
            }else
            {
                btn.enabled = YES;
            }
        }];
   

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
