//
//  BookView.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/11/29.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

typedef void(^BookViewBlock)(void);
@interface BookView : UIView

@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,copy) BookViewBlock block;


@end
