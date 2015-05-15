//
//  MTLValueTransformer+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 08.05.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "MTLValueTransformer+AIKit.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation MTLValueTransformer (AIKit)

+ (instancetype)ai_transformerFromClass:(Class)fromClass
                           forwardBlock:(id (^)(id object))forwardBlock
                           reverseBlock:(id (^)(id object))reverseBlock
{
    NSParameterAssert(fromClass != nil);
    
    return [self reversibleTransformerWithForwardBlock:^id(id object) {
        if ([object isKindOfClass:fromClass]) {
            return forwardBlock(object);
        }
        return nil;
    } reverseBlock:reverseBlock];
}

+ (instancetype)ai_valueTransformerWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSParameterAssert(dateFormatter != nil);
    
    return [self ai_transformerFromClass:[NSString class] forwardBlock:^NSDate *(NSString *str) {
        return [dateFormatter dateFromString:str];
    } reverseBlock:^NSString *(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
}

@end

@implementation NSValueTransformer (AIKit)

+ (instancetype)ai_valueTransformerWithEnum:(NSArray *)aEnum
                               defaultValue:(NSNumber *)defaultValue
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:aEnum
                                                     forKeys:aEnum];
    
    return [self mtl_valueMappingTransformerWithDictionary:dict
                                              defaultValue:defaultValue
                                       reverseDefaultValue:defaultValue];
}

@end

