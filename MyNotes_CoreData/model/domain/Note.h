//
//  Note.h
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/14.
//  Copyright © 2020 俊杰李. All rights reserved.
//
//
//#ifndef Note_h
//#define Note_h
//
//
//#endif /* Note_h */

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (nonatomic,strong) NSDate * date;
@property (nonatomic,strong) NSString * content;

- (instancetype) initWithDate:(NSDate *) date content:(NSString *) content;


- (instancetype) init;

@end
