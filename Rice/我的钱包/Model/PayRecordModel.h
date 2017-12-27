//
//  PayRecordModel.h
//  Rice
//
//  Created by ZhangWeiLiang on 2017/12/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayRecordModel : NSObject

@property(nonatomic,strong) NSString *typeName;
@property(nonatomic,strong) NSString *createTime;
@property(nonatomic,strong) NSString *money;
@property(nonatomic,assign) BOOL isAdd;


@end
