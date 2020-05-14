//
//  Note.m
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/14.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "Note.h"

@implementation Note
 
-(instancetype) init{
    self = [super init];
       if(self){
           self.date = [[NSDate alloc] init];
           self.content= @"";
       }
       return self;
}
-(instancetype) initWithDate:(NSDate *)date content:(NSString *)content{
    self = [super init];
    if(self){
        self.date = date;
        self.content= content;
    }
    return self;
}

#pragma mark--实现NSCoding协议
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.content forKey:@"content"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    [coder decodeObjectForKey:@"date"];
    [coder decodeObjectForKey:@"content"];
    return self;
}

@end
