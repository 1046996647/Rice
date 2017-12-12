//
//  LZQTimerLabel.m
//  LZQTimerLabelTest
//
//  Created by 路准晴 on 16/10/28.
//  Copyright © 2016年 luzhunqing. All rights reserved.
//

#import "LZQTimerLabel.h"

//#define kDefaultTimeFormat  @"HH:mm:ss"
#define kDefaultTimeFormat  @"mm:ss"
//#define kDefaultTimeFormat  @"ss"
#define kDefaultFireIntervalNormal  0.1
#define kDefaultFireIntervalHighUse  0.02

@interface LZQTimerLabel ()

@property (nonatomic,strong)NSTimer *timer;
- (void)initParameter;
- (void)updateLabel:(NSTimer *)timer;
@end

@implementation LZQTimerLabel

-(id)init
{
    self = [super init];
    if (self)
    {
        _timeLabel = self;
        _timerType = LZQTimerLabelTypeWithCountdown;
    }
    return self;
}

-(id)initWithTimerType:(LZQTimerLabelType)theType withDelegate:(id)delegate
{
    return [self initWithLabel:nil andTimerType:theType withDelegate:delegate];
}

-(id)initWithLabel:(UILabel*)theLabel withDelegate:(id)delegate
{
    return [self initWithLabel:theLabel andTimerType:LZQTimerLabelTypeWithCountdown  withDelegate:delegate];
}
-(id)initWithLabel:(UILabel*)theLabel andTimerType:(LZQTimerLabelType)theType withDelegate:(id)delegate
{
    self = [super init];
    
    if(self){
        _delegate = delegate;
        _timeLabel = theLabel;
        _timerType = theType;
        [self initParameter];
    }
    return self;
}


-(void)initParameter{
    
    if ([_timeFormat length] == 0)
    {
        _timeFormat = kDefaultTimeFormat;
    }
    
    if(_timeLabel == nil){
        _timeLabel = self;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    if(dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:_timeFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
    
    if (date1970 == nil) {
        
        date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    }
    
    [self updateLabel:nil];
}

-(void)updateLabel:(NSTimer*)timer
{
    
    NSTimeInterval timeDiff = [[[NSDate alloc] init] timeIntervalSinceDate:startCountDate];
    NSDate *timeToShow = [NSDate date];
    
    if(_timerType == LZQTimerLabelTypeWithNormal)
    {
        
        if (_counting)
        {
            timeToShow = [date1970 dateByAddingTimeInterval:timeDiff];
        }else
        {
            timeToShow = [date1970 dateByAddingTimeInterval:(!startCountDate)?0:timeDiff];
        }
        
        
    }else
    {
        
        //timer now
        
        if (_counting)
        {
 
            if(fabs(timeDiff) >= timeUserValue)
            {
                [self pause];
                timeToShow = [date1970 dateByAddingTimeInterval:0];
                pausedTime = nil;
                startCountDate = nil;
    
            }else
            {
                timeToShow = [timeToCountOff dateByAddingTimeInterval:(timeDiff*-1)];
            }

            
        }else
        {
            timeToShow = timeToCountOff;
        }
       
    }
    
    NSString *strDate = [dateFormatter stringFromDate:timeToShow];
    _timeLabel.text = strDate;
    
    NSArray *arr = [strDate componentsSeparatedByString:@":"];
    
    NSString *hrStr = arr[0];

    NSString *minStr = arr[1];
    
    strDate = [NSString stringWithFormat:@"%ld",hrStr.integerValue*60+minStr.integerValue];
    
//    NSLog(@"%ld",minStr.integerValue);
    NSLog(@"%@",strDate);
//    NSLog(@"%@",strDate);
    
    if ([_delegate respondsToSelector:@selector(updateTimer:)])
    {
        [_delegate updateTimer:strDate];

    }

}

-(void)pause
{
    [_timer invalidate];
    _timer = nil;
    _counting = NO;
    pausedTime = [NSDate date];
    
    if ([_delegate respondsToSelector:@selector(pausTimer:)])
    {
        NSTimeInterval timeInterval = 0;
        if (_timerType == LZQTimerLabelTypeWithCountdown )
        {
            timeInterval = timeUserValue;
        }
        else
        {
            timeInterval = [pausedTime timeIntervalSinceDate:startCountDate];
        }
        NSDate *timeDate = [date1970 dateByAddingTimeInterval:timeInterval];
        
        NSString *timePauseTime = [dateFormatter stringFromDate:timeDate];
        [_delegate pausTimer:timePauseTime];
    }
    startCountDate = nil;
    pausedTime = nil;
    [self updateLabel:nil];
}
-(void)start
{
    
    [self initParameter];
    if(_timer == nil)
    {
        
        if ([_timeFormat rangeOfString:@"SS"].location != NSNotFound) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        }else{
            _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        }
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        if(startCountDate == nil)
        {
            startCountDate = [NSDate date];
            
        }
        if(pausedTime != nil){
            NSTimeInterval countedTime = [pausedTime timeIntervalSinceDate:startCountDate];
            startCountDate = [[NSDate date] dateByAddingTimeInterval:-countedTime];
            pausedTime = nil;
        }
        
        _counting = YES;
        [_timer fire];
        
    }
}



-(void)setCountDownTime:(NSTimeInterval)time{
    
    timeUserValue = time;
    timeToCountOff = [date1970 dateByAddingTimeInterval:time];
    [self updateLabel:nil];
}



@end
