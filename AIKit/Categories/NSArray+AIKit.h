//
//  NSArray+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 08.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

@interface NSArray (AIKit)

- (NSArray *)ai_numberMap:(id (^)(NSNumber *number))map;
- (NSArray *)ai_stringMap:(id (^)(NSString *string))map;
- (NSArray *)ai_arrayMap:(id (^)(NSArray *array))map;

- (NSArray *)ai_objectsOfClass:(Class)aClass map:(id (^)(id object))map;
- (NSArray *)ai_filter:(BOOL (^)(id object))filter map:(id (^)(id object))map;


- (NSNumber *)ai_numberAtIndex:(NSUInteger)index;
- (id)ai_objectAtIndex:(NSUInteger)index ofClass:(Class)aClass;


- (void)ai_respondsToSelector:(SEL)aSelector
                    enumerate:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;

- (void)ai_predicate:(BOOL (^)(id obj))predicate
           enumerate:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;

@end
