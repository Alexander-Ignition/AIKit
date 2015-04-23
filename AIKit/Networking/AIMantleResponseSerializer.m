//
//  AIMantleResponseSerializer.m
//  AIKit
//
//  Created by Alexander Ignition on 22.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "AIMantleResponseSerializer.h"
#import "NSDictionary+AIKit.h"
#import <Mantle/MTLJSONAdapter.h>

typedef void (^AISerializerCompletionBlock)(id obj, NSError *error);

@implementation AIMantleResponseSerializer

- (instancetype)init {
    if (self = [super init]) {
        self.dispatch_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSON = [super responseObjectForResponse:response data:data error:error];
    
    Class JSONClass = [self validJSONClass];
    
    if (!JSON || !JSONClass) {
        return JSON;
    }
    
    if ([JSON isKindOfClass:JSONClass] == NO) {
        *error = [self badServerResponseError];
        return nil;
    }
    
    return JSON;
}

- (Class)validJSONClass
{
    switch (self.responseType) {
        case AIResponseTypeDictionary:
            return [NSDictionary class];
        
        case AIResponseTypeArray:
            return [NSArray class];
        
        case AIResponseTypeJSON:
        default:
            return nil;
    }
}

- (NSError *)badServerResponseError
{
    return [[NSError alloc] initWithDomain:NSURLErrorDomain
                                      code:NSURLErrorBadServerResponse
                                  userInfo:nil];
}

#pragma mark - Response for Key

- (void)parse:(id)object
        model:(Class)model
      inArray:(BOOL)inArray
       forKey:(NSString *)key
         task:(NSURLSessionDataTask *)task
      success:(AISerializerAnyBlock)success
      failure:(AISerializerErrorBlock)failure
{
    if (key) {
        if ([object isKindOfClass:NSDictionary.class]) {
            
            NSDictionary *dict = (NSDictionary *)object;
            id obj = [dict ai_objectForKey:key];
            [self parse:obj model:model inArray:inArray task:task success:success failure:failure];
        
        } else {
            
            NSError *error = [self badServerResponseError];
            [self sendObject:error withTask:task inBlock:failure];
        }
        
    } else {
        [self parse:object model:model inArray:inArray task:task success:success failure:failure];
    }
}

#pragma mark - Response

- (void)parse:(id)object
        model:(Class)model
       inArray:(BOOL)inArray
          task:(NSURLSessionDataTask *)task
       success:(AISerializerAnyBlock)success
       failure:(AISerializerErrorBlock)failure
{
    [self parse:object model:model inArray:inArray completion:^(id obj, NSError *error) {
        if (object) {
            [self sendObject:obj withTask:task inBlock:success];
        } else {
            [self sendObject:error withTask:task inBlock:failure];
        }
    }];
}

#pragma mark - JSON Parse

- (void)parse:(id)object
        model:(Class)model
      inArray:(BOOL)inArray
   completion:(AISerializerCompletionBlock)completion
{
    if ([self isJSONClass:model]) {
        [self parse:object JSONModel:model inArray:inArray completion:completion];
    } else {
        [self parse:object MTLModel:model inArray:inArray completion:completion];
    }
}

- (BOOL)isJSONClass:(Class)aClass {
    return [aClass isSubclassOfClass:NSDictionary.class] || [aClass isSubclassOfClass:NSArray.class];
}

- (void)parse:(id)object
    JSONModel:(Class)model
      inArray:(BOOL)inArray
   completion:(AISerializerCompletionBlock)completion
{
    NSError *error;
    id obj = [self parse:object JSONModel:model inArray:inArray error:&error];
    if (completion) {
        completion(obj, error);
    }
}

- (id)parse:(id)object JSONModel:(Class)model inArray:(BOOL)inArray error:(NSError **)error
{
    Class aClass = inArray ? [NSArray class] : [NSDictionary class];
    if ([model isSubclassOfClass:aClass] && [object isKindOfClass:aClass]) {
        return object;
    }
    *error = [self badServerResponseError];
    return nil;
}

#pragma mark - Mantle

- (void)parse:(id)object
     MTLModel:(Class)model
      inArray:(BOOL)inArray
   completion:(AISerializerCompletionBlock)completion
{
    dispatch_async(self.dispatch_queue, ^{
        NSError *error;
        id obj = [self parse:object MTLModel:model inArray:inArray error:&error];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(obj, error);
            });
        }
    });
}

- (id)parse:(id)object MTLModel:(Class)model inArray:(BOOL)inArray error:(NSError **)error {
    if (inArray) {
        return [MTLJSONAdapter modelsOfClass:model fromJSONArray:object error:error];
    }
    return [MTLJSONAdapter modelOfClass:model fromJSONDictionary:object error:error];
}

#pragma mark - Perform Block

- (void)sendObject:(id)object
          withTask:(NSURLSessionDataTask *)task
           inBlock:(AISerializerAnyBlock)block
{
    if (block) {
        block(task, object);
    }
}

@end
