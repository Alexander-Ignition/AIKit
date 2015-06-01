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

+ (NSEntityDescription *)ai_entityWithContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:[self ai_entityName] inManagedObjectContext:context];
}

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [[self class] ai_entityWithContext:context];
    return [self initWithEntity:entity insertIntoManagedObjectContext:context];
}

@end
