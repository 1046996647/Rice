//
//  LZQTimerLabel.h
//  LZQTimerLabelTest
//
//  Created by 路准晴 on 16/10/28.
//  Copyright © 2016年 luzhunqing. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LZQTimerLabelDelegate <NSObject>

@optional

//定时器更新的时间
- (void)updateTimer:(NSString *)date;

//定时器运行的时间
- (void)pausTimer:(NSString *)date;

@end
// 定义两种类型，倒计时和正常计时
typedef enum
{
    LZQTimerLabelTypeWithCountdown,
     LZQTimerLabelTypeWithNormal,
}LZQTimerLabelType;


@interface LZQTimerLabel : UILabel
{
    //   倒计时总时间
    NSTimeInterval timeUserValue;
    //    开始时间
    NSDate *startCountDate;
    //    停止时间
    NSDate *pausedTime;
    //    从那个时间开始计算
    NSDate *date1970;
    //    用的总时间
    NSDate *timeToCountOff;
    //    日期格式化器具
    NSDateFormatter *dateFormatter;
}

@property (nonatomic,assign)id<LZQTimerLabelDelegate>    delegate;
//格式化器的格式
@property (nonatomic,strong) NSString *timeFormat;

//默认的label
@property (strong) UILabel *timeLabel;

//label类型
@property (assign) LZQTimerLabelType timerType;

//定时器是否在运行
@property (assign,readonly) BOOL counting;


//初始化label的方法
-(id)initWithTimerType:(LZQTimerLabelType)theType withDelegate:(id)delegate;
-(id)initWithLabel:(UILabel*)theLabel andTimerType:(LZQTimerLabelType)theType withDelegate:(id)delegate;
-(id)initWithLabel:(UILabel*)theLabel withDelegate:(id)delegate;

/*--------Timer的一些控制方法------------*/
//开始计时
-(void)start;
//停止计时
-(void)pause;


/*--------设置倒计时----------------*/
-(void)setCountDownTime:(NSTimeInterval)time;


@end
