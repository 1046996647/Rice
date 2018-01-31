//
//  SystemModel.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SystemModel.h"

@implementation SystemModel

//+ (NSDictionary *)modelCustomPropertyMapper
//{
//    return @{@"ID" : @"id"};
//}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
//    NSString *timeStr = [[dic[@"add_time"] componentsSeparatedByString:@" "] firstObject];
////    timeStr = [timeStr substringFromIndex:5];
//    _add_time = timeStr;
    
    return YES;
}

@end
