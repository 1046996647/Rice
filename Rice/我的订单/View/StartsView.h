//
//  StartsView.h
//  StartsTest
//
//  Created by 李聪会 on 2016/10/11.
//  Copyright © 2016年 李聪会. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StartsViewBlock)(NSMutableArray *StartsBtns);

/**
 评价星星图
 **/
@interface StartsView : UIView

@property (strong, nonatomic) NSMutableArray *StartsBtns;
@property (strong, nonatomic)  UIView *panView;
@property(nonatomic,copy) StartsViewBlock block;


- (void)addSwipeGesture;
@end
