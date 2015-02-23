//
//  NSDictionary+AIKit.m
//  AIKit
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSDictionary+AIKit.h"

@implementation NSDictionary (AIKit)

- (id)ai_objectForKey:(id)key {
    id object = [self objectForKey:key];
    return [object isEqual:[NSNull null]] ?  nil : object;
}

- (id)ai_objectForKey:(id)key kindOfClass:(Class)aClass {
    id object = [self objectForKey:key];
    return [object isKindOfClass:aClass] ? object : nil;
}

- (NSString *)ai_stringForKey:(id)key {
    return [self ai_objectForKey:key kindOfClass:[NSString class]];
}

- (NSNumber *)ai_numberForKey:(id)key {
    return [self ai_objectForKey:key kindOfClass:[NSNumber class]];
}

- (NSArray *)ai_arrayForKey:(id)key {
    return [self ai_objectForKey:key kindOfClass:[NSArray class]];
}

- (NSDictionary *)ai_dictionaryForKey:(id)key {
    return [self ai_objectForKey:key kindOfClass:[NSDictionary class]];
}

@end
