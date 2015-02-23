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

@end
