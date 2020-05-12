//
//  Note.h
//  My_Notes
//
//  Created by 俊杰李 on 2020/5/12.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(nonatomic, strong) NSDate* date;
@property(nonatomic, strong) NSString* content;

-(instancetype)initWithDate:(NSDate*)date content:(NSString*)content;

-(instancetype)init;

@end
