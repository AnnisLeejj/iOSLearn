//
//  NoteDao.h
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/15.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "CoreDataBaseDao.h"

@interface NoteDao : CoreDataBaseDao

+(NoteDao*) sharedInstance;

-(int) insert:(Note*) note;

-(int) delete:(Note*) note;

-(int) modify:(Note*) note;

-(NSMutableArray*) findAll;

-(Note*) findById:(Note*) note;

@end
