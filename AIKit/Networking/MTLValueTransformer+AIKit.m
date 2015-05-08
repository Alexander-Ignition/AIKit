//
//  MTLValueTransformer+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 08.05.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "MTLValueTransformer+AIKit.h"

@implementation MTLValueTransformer (AIKit)

+ (instancetype)ai_reversibleTransformerStringWithForwardBlock:(id (^)(NSString *str))forwardBlock
                                               reverseBlock:(NSString *(^)(id object))reverseBlock
{
    return [self ai_reversibleTransformerWithModel:[NSString class] forwardBlock:forwardBlock reverseBlock:reverseBlock];
}

+ (instancetype)ai_reversibleTransformerArrayWithForwardBlock:(id (^)(NSArray *array))forwardBlock
                                              reverseBlock:(NSArray *(^)(id object))reverseBlock
{
    return [self ai_reversibleTransformerWithModel:[NSArray class] forwardBlock:forwardBlock reverseBlock:reverseBlock];
}

+ (instancetype)ai_reversibleTransformerWithModel:(Class)aModel
                                  forwardBlock:(id (^)(id object))forwardBlock
                                  reverseBlock:(id (^)(id object))reverseBlock
{
    NSParameterAssert(aModel != nil);
    NSParameterAssert(forwardBlock != nil);
    NSParameterAssert(reverseBlock != nil);
    
    return [self reversibleTransformerWithForwardBlock:^id(id object) {
        if ([object isKindOfClass:aModel] == NO) { return nil; }
        return forwardBlock(object);
    } reverseBlock:reverseBlock];
}

@end
