//
//  NSDictionary+AIKit.h
//  AIKit
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

@interface NSDictionary (AIKit)

- (id)ai_objectForKey:(id)key;
- (id)ai_objectForKey:(id)key kindOfClass:(Class)aClass;

- (NSString *)ai_stringForKey:(id)key;
- (NSNumber *)ai_numberForKey:(id)key;

- (NSArray *)ai_arrayForKey:(id)key;
- (NSDictionary *)ai_dictionaryForKey:(id)key;

@end
