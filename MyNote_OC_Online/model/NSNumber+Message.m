//
//  NSNumber+Message.m
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "NSNumber+Message.h"

@implementation NSNumber (Message)

-(NSString *)errorMessage{
    switch ([self integerValue]) {
        case -7:
            return  @"没有数据。";
            break;
        case -6:
            return  @"日期没有输入。";
            break;
        case -5:
            return  @"内容没有输入。";
            break;
        case -4:
            return  @"ID没有输入。";
            break;
        case -3:
            return  @"据访问失败。";
            break;
        case -2:
            return  @"您的账号最多能插入10条数据。";
            break;
        case -1:
            return   @"用户不存在，请到51work6.com注册。";
        default:
            return   @"";
            break;
    }
}

@end
