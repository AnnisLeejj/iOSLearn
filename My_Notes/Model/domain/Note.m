//
//  Note.m
//  My_Notes
//
//  Created by 俊杰李 on 2020/5/12.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "Note.h"

@implementation Note

-(instancetype) initWithDate:(NSDate *)date content:(NSString *)content{
    self = [super init];
    if(self){
        self.date = date ;
        self.content = content;
    }
    return self;
}
-(instancetype) init{
    self = [super init];
    if(self){
        self.date = [NSDate alloc];//[[NSDate alloc] init];
        self.content = @"";
    }
    return self;
}

@end
