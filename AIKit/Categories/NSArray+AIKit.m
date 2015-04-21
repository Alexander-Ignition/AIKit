//
//  NSArray+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 08.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSArray+AIKit.h"

@implementation NSArray (AIKit)

- (NSArray *)ai_numberMap:(id (^)(NSNumber *number))map {
    return [self ai_filterIsKindOfClass:[NSNumber class] map:map];
}

- (NSArray *)ai_stringMap:(id (^)(NSString *string))map {
    return [self ai_filterIsKindOfClass:[NSString class] map:map];
}

- (NSArray *)ai_arrayMap:(id (^)(NSArray *array))map {
    return [self ai_filterIsKindOfClass:[NSArray class] map:map];
}

- (NSArray *)ai_filterIsKindOfClass:(Class)aClass map:(id (^)(id object))map {
    NSParameterAssert(aClass != nil);
    
    return [self ai_filter:^BOOL(id object) {
        return [object isKindOfClass:aClass];
    } map:map];
}

- (NSArray *)ai_filter:(BOOL (^)(id object))filter map:(id (^)(id object))map {
    NSParameterAssert(filter != nil);
    NSParameterAssert(map != nil);
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:self.count];
    for (id object in self) {
        if (filter(object) == NO) { continue; }
        
        id newObject = map(object);
        
        if (newObject == nil) { continue; }
        
        [mArray addObject:newObject];
    }
    return mArray.count > 0 ? mArray : nil;
}

#pragma mark -

- (NSNumber *)ai_numberAtIndex:(NSUInteger)index {
    return [self ai_objectAtIndex:index isKindOfClass:[NSNumber class]];
}

- (id)ai_objectAtIndex:(NSUInteger)index isKindOfClass:(Class)aClass {
    if (self.count > index) {
        id object = self[index];
        return [object isKindOfClass:aClass] ? object : nil;
    }
    return nil;
}

#pragma mark -

- (void)ai_respondsToSelector:(SEL)aSelector
                    enumerate:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self ai_predicate:^BOOL(id obj) {
        return [obj respondsToSelector:aSelector];
    } enumerate:block];
}

- (void)ai_predicate:(BOOL (^)(id obj))predicate
           enumerate:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    NSParameterAssert(predicate);
    NSParameterAssert(block);
    
    for (NSUInteger i = 0; i < self.count; i++) {
        id obj = [self objectAtIndex:i];
        
        if (predicate(obj) == NO) { continue; }
        
        BOOL stop;
        block(obj, i, &stop);
        
        if (stop == YES) { break; }
    }
}

@end
