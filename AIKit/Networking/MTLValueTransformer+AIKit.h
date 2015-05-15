//
//  MTLValueTransformer+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 08.05.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "MTLValueTransformer.h"

@interface MTLValueTransformer (AIKit)

+ (instancetype)ai_transformerFromClass:(Class)fromClass
                           forwardBlock:(id (^)(id object))forwardBlock
                           reverseBlock:(id (^)(id object))reverseBlock;

+ (instancetype)ai_valueTransformerWithDateFormatter:(NSDateFormatter *)dateFormatter;

@end

@interface NSValueTransformer (AIKit)

+ (instancetype)ai_valueTransformerWithEnum:(NSArray *)aEnum
                               defaultValue:(NSNumber *)defaultValue;

@end
