//
//  NSManagedObject+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 01.06.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSManagedObject+AIKit.h"

@implementation NSManagedObject (AIKit)

+ (NSString *)ai_entityName {
    return NSStringFromClass([self class]);
}

+ (NSFetchRequest *)ai_fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:[self ai_entityName]];
}

+ (instancetype)ai_insertNewObjectInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self ai_entityName] inManagedObjectContext:context];
}

- (BOOL)ai_save:(NSError **)error
{
    NSManagedObjectContext *context = self.managedObjectContext;
    if (context == nil) {
        return NO;
    }
    if (context.hasChanges == NO) {
        return YES;
    }
    return [context save:error];
}

@end
