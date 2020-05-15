//
//  NoteManagedObject+CoreDataProperties.h
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/15.
//  Copyright © 2020 俊杰李. All rights reserved.
//
//

#import "NoteManagedObject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NoteManagedObject (CoreDataProperties)

+ (NSFetchRequest<NoteManagedObject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *date;

@end

NS_ASSUME_NONNULL_END
