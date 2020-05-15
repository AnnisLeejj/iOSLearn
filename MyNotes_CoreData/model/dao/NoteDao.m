//
//  NoteDao.m
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/15.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NoteDao.h"
#import "NoteManagedObject+CoreDataProperties.h"

@interface NoteDao() //声明NoteDAO扩展

//NoteDAO扩展中DateFormatter属性是私有的
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@end

@implementation NoteDao

static NoteDao * sharedSingleleton = nil;

//+(NoteDao*) sharedInstance;
//
//-(int) insert:(Note*) note;
//
//-(int) delete:(Note*) note;
//
//-(int) modify:(Note*) note;
//
//-(NSMutableArray*) findAll;
//
//-(Note*) findById:(Note*) note;

+ (NoteDao*) sharedInstance{
    static dispatch_once_t once;
    
    dispatch_once(&once,^{
        sharedSingleleton = [[self alloc] init];
        sharedSingleleton.dateFormatter = [[NSDateFormatter alloc] init];
        sharedSingleleton.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return sharedSingleleton;
}

- (int) insert:(Note *)note{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NoteManagedObject *noteManage = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    
    noteManage.content = note.content;
    noteManage.date = note.date;
    
    [self saveContext];
    
    return 0;
}
//-(int) delete:(Note*) note;
-(int) delete:(Note *)note{
    NSManagedObjectContext* context = self.persistentContainer.viewContext;
    //   NoteManagedObject* noteManage =  [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    NSEntityDescription* entityDescription =  [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"date = %@",note.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error ];
    
    if (error==nil&& [array count]>0){
        NoteManagedObject * object =  [array lastObject];
        [context deleteObject:object];
        [self saveContext];
    }
    return 0;
}
//-(int) modify:(Note*) note;
-(int) modify:(Note *)note{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription * description = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    [request setEntity:description];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"date = %@",note.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if(error==nil&&[array count]>0){
        NoteManagedObject * object = [array lastObject];
        object.content=note.content;
        
        [self saveContext];
    }
    
    return 0;
}
//-(NSMutableArray*) findAll;
-(NSMutableArray*)findAll{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];

    NSEntityDescription *description = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    //    [request setEntity:description];
    request.entity = description;

    //这里不需要条件查询
    //    NSPredicate * predicate = [NSPredicate predicateWithFormat:@""]
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;

    NSError * error=nil;
    NSArray* array = [context executeFetchRequest:request error:&error];

    if (error!=nil) {
        return nil;
    }

    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for(NoteManagedObject * object in array){
        Note *note = [[Note alloc] initWithDate:object.date content:object.content];
        [resultArray addObject:note];
    }
    return resultArray;
}

//-(Note*) findById:(Note*) note;
-(Note *) findById:(Note *)note{
    NSManagedObjectContext *context =  self.persistentContainer.viewContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    request.entity = entity;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",note.date];
    request.predicate =predicate;
    
    NSError* error=nil;
    NSArray * array =[context executeFetchRequest:request error:&error];
    
    if(error==nil&&[array count]>0 ){
        NoteManagedObject* object = [array lastObject];
        Note* note = [[Note init] initWithDate:object.date content:object.content];
        return note;
    }
     return nil;
}
@end
