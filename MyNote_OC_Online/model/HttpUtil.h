//
//  HttpUtil.h
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Message.h"

@interface HttpUtil : NSObject

//添加数据
-(void) addNote:(NSString*) account dateStr:(NSString*)dateStr contentStr:(NSString*)contentStr completionHandler:(void (^)(NSDictionary *resDict, NSError *error))completionHandler;
//删除数据
-(void) removeById:(NSString*) account  mid: (NSString*) mid   completionHandler:(void (^)(NSDictionary *resDict, NSError *error))completionHandler;
//修改数据
-(void) motify:(NSString*) account  mid: (NSString*) mid dateStr:(NSString*)dateStr contentStr:(NSString*)contentStr
        completionHandler:(void (^)(NSDictionary *resDict, NSError *error))completionHandler;
//查询数据
-(void) loadAll:(NSString*) account completionHandler:(void (^)(NSDictionary *resDict, NSError *error))completionHandler;
@end
