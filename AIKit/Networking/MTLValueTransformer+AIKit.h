//
//  MTLValueTransformer+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 08.05.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "MTLValueTransformer.h"

@interface MTLValueTransformer (AIKit)

+ (instancetype)ai_reversibleTransformerStringWithForwardBlock:(id (^)(NSString *str))forwardBlock
                                                  reverseBlock:(NSString *(^)(id object))reverseBlock;

+ (instancetype)ai_reversibleTransformerArrayWithForwardBlock:(id (^)(NSArray *array))forwardBlock
                                                 reverseBlock:(NSArray *(^)(id object))reverseBlock;

+ (instancetype)ai_reversibleTransformerWithModel:(Class)aModel
                                     forwardBlock:(id (^)(id object))forwardBlock
                                     reverseBlock:(id (^)(id object))reverseBlock;

@end
