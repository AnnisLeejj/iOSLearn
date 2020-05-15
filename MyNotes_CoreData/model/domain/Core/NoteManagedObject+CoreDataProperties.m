//
//  NoteManagedObject+CoreDataProperties.m
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/15.
//  Copyright © 2020 俊杰李. All rights reserved.
//
//

#import "NoteManagedObject+CoreDataProperties.h"

@implementation NoteManagedObject (CoreDataProperties)

+ (NSFetchRequest<NoteManagedObject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Note"];
}

@dynamic content;
@dynamic date;

@end
