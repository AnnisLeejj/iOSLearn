//
//  CoreDataBaseDao.h
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/15.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataBaseDao : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end
