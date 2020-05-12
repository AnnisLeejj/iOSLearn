//
//  NoteDao.h
//  My_Notes
//
//  Created by 俊杰李 on 2020/5/12.
//  Copyright © 2020 俊杰李. All rights reserved.
//
 
#import <Foundation/Foundation.h>

#import "Note.h"

@interface NoteDao : NSObject

+(NoteDao*)sharedInstance;

-(int) insert:(Note*) note;

-(int) remove:(Note*) note;

-(int) modify:(Note*) note;

-(NSMutableArray*) findAll;

-(Note*) findById:(Note*) note;
@end
