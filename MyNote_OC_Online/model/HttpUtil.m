//
//  HttpUtil.m
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "HttpUtil.h"

@implementation HttpUtil
-(void) addNote:(NSString *)account dateStr:(NSString *)dateStr contentStr:(NSString *)contentStr completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler{
    //设置参数
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@",
                        account, @"JSON", @"add", dateStr, contentStr];
    NSData *data =[params dataUsingEncoding:NSUTF8StringEncoding];
    
    [self simpleHttp:data completionHandler:completionHandler];
}
-(void) loadAll:(NSString*) account completionHandler:(void (^)(NSDictionary *resDict, NSError *error))completionHandler {
    NSString * params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@",account,@"JSON", @"query"];
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [self simpleHttp:postData completionHandler:completionHandler];
}

-(void) motify:(NSString *)account mid:(NSString *)mid dateStr:(NSString *)dateStr contentStr:(NSString *)contentStr completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler{
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@&id=%@",
                      account, @"JSON", @"modify", dateStr,contentStr, mid];
    NSData *params =  [post dataUsingEncoding:NSUTF8StringEncoding];
    [self simpleHttp:params completionHandler:completionHandler];
}

-(void) removeById:(NSString *)account mid:(NSNumber *)mid completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler{
    NSString * params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",account,@"JSON", @"remove",mid];
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [self simpleHttp:postData completionHandler:completionHandler];
}

/**
 *抽取公共代码
 */
-(void) simpleHttp: (NSData*)postData completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler{
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    //AFNetworking 请求
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:strURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL ];
   NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:postData];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress: %lld / %lld", uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress: %lld / %lld", downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
             completionHandler(nil,error);
        } else {
//            NSLog(@"%@ %@", response, responseObject);
//            NSDictionary *resDict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
             completionHandler(responseObject,error);
        }
    }];

    [dataTask resume];
     
    
    
    //iOS 原生框架
//        NSURL *url = [NSURL URLWithString:strURL];
//
//        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
//        [request setHTTPMethod:@"post"];
//        [request setHTTPBody:postData];
//
//        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//
//        NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//            NSLog(@"请求完成...");
//            if(error){
//                completionHandler(nil,error);
//            }else{
//                NSDictionary *resDict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                completionHandler(resDict,error);
//            }
//        }];
//        [task resume];
}
@end
