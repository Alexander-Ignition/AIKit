//
//  NSManagedObject+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 01.06.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import CoreData;

@interface NSManagedObject (AIKit)

+ (NSString *)ai_entityName;

+ (NSFetchRequest *)ai_fetchRequest;

+ (instancetype)ai_insertNewObjectInContext:(NSManagedObjectContext *)context;

- (BOOL)ai_save:(NSError **)error;

@end
