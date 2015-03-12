//
//  NSJSONSerialization+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 24.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSJSONSerialization+AIKit.h"

NSString * const AIJSONSerializationErrorDomain = @"AIJSONSerializationErrorDomain";

@implementation NSJSONSerialization (AIKit)

#pragma mark - NSString From JSON

+ (NSString *)stringFromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error {
    return [self stringFromJSON:JSONDictionary error:error];
}

+ (NSString *)stringFromJSONArray:(NSArray *)JSONArray error:(NSError **)error {
    return [self stringFromJSON:JSONArray error:error];
}

+ (NSString *)stringFromJSON:(id)JSON error:(NSError **)error
{
    if ([self isValidJSONObject:JSON]) {
        
        NSData *dataFromJSON = [NSJSONSerialization dataWithJSONObject:JSON options:0 error:error];
        if (dataFromJSON) {
            return [[NSString alloc] initWithData:dataFromJSON encoding:NSUTF8StringEncoding];
        }
        return nil;
    }
    if (error != NULL) {
        *error = [NSError errorWithDomain:AIJSONSerializationErrorDomain
                                     code:AIJSONSerializationErrorInvalidType
                                 userInfo:nil];
    }
    return nil;
}


#pragma mark - JSON From NSString

+ (NSDictionary *)JSONDictionaryFromString:(NSString *)string error:(NSError **)error
{
    id JSON = [self JSONFromString:string error:error];
    return [self JSON:JSON forClass:[NSDictionary class] error:error];
}

+ (NSArray *)JSONArrayFromString:(NSString *)string error:(NSError **)error
{
    id JSON = [self JSONFromString:string error:error];
    return [self JSON:JSON forClass:[NSArray class] error:error];
}

+ (id)JSONFromString:(NSString *)string error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [self JSONObjectWithData:data options:0 error:error];
    }
    if (error != NULL) {
//        *error = [NSError errorJSONSerialization];
    }
    return nil;
}

+ (id)JSON:(id)JSON forClass:(Class)class error:(NSError **)error
{
    if ([JSON isKindOfClass:class]) {
        return JSON;
    }
    if (error != NULL) {
//        *error = [NSError errorJSONSerialization];
    }
    return nil;
}


#pragma mark - JSON From id

+ (id)JSONFromObject:(id)object error:(NSError **)error
{
    if ([object isKindOfClass:[NSString class]]) {
        return [self JSONFromString:object error:error];
    }
    
    if ([object isKindOfClass:[NSData class]]) {
        return [self JSONObjectWithData:object options:0 error:error];
    }
    
    if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    
    if (error != NULL) {
//        *error = [NSError errorBadServerResponse:nil];
    }
    return nil;
}

+ (NSDictionary *)JSONDictionaryFromResponse:(id)response error:(NSError **)error
{
    if ([response isKindOfClass:[NSString class]] == YES) {
        return [self JSONDictionaryFromString:response error:error];
    }
    
    if (error != NULL) {
//        *error = [NSError errorBadServerResponse:nil];
    }
    return nil;
}

@end
