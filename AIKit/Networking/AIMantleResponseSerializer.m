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
    
    Class JSONClass = [self classFromType:self.responseType];
    
    if (!JSON || !JSONClass) {
        return JSON;
    }
    
    if ([JSON isKindOfClass:JSONClass] == NO) {
        *error = [self errorBadServerResponse];
        return nil;
    }
    
    if (self.responseHandler) {
        *error = self.responseHandler(response, JSON);
        if (error) {
            return nil;
        }
    }
    
    return JSON;
}

- (Class)classFromType:(AIResponseType)type {
    switch (type) {
        case AIResponseTypeDictionary:
            return [NSDictionary class];
            
        case AIResponseTypeArray:
            return [NSArray class];
            
        case AIResponseTypeJSON:
        default:
            return nil;
    }
}

- (NSError *)errorBadServerResponse {
    return [[NSError alloc] initWithDomain:NSURLErrorDomain
                                      code:NSURLErrorBadServerResponse
                                  userInfo:nil];
}

#pragma mark - Mantle

- (void)parseJSON:(id)JSON
           forKey:(NSString *)key
          inModel:(Class)modelClass
          inArray:(BOOL)inArray
             task:(NSURLSessionDataTask *)task
          success:(AISerializerAnyBlock)success
          failure:(AISerializerErrorBlock)failure
{
    id object = [self objectFromJSON:JSON forKey:key];
    
    [self parseJSON:object inModel:modelClass inArray:inArray completion:^(id model, NSError *error) {
        if (model) {
            [self sendObject:model withTask:task inBlock:success];
        } else {
            [self sendObject:error withTask:task inBlock:failure];
        }
    }];
}

- (id)objectFromJSON:(id)JSON forKey:(id)key
{
    if (key && [JSON isKindOfClass:[NSDictionary class]]) {
        return [JSON ai_objectForKey:key];
    }
    return JSON;
}

- (void)parseJSON:(id)JSON
          inModel:(Class)modelClass
          inArray:(BOOL)inArray
       completion:(void (^)(id model, NSError *error))completion
{
    NSParameterAssert(completion);
    
    dispatch_async(self.dispatch_queue, ^{
        NSError *error;
        id model = [self parseJSON:JSON inModel:modelClass inArray:inArray error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(model, error);
        });
    });
}

- (id)parseJSON:(id)JSON inModel:(Class)model inArray:(BOOL)inArray error:(NSError **)error {
    if (inArray) {
        return [MTLJSONAdapter modelsOfClass:model fromJSONArray:JSON error:error];
    }
    return [MTLJSONAdapter modelOfClass:model fromJSONDictionary:JSON error:error];
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
