//
//  NSJSONSerialization+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 24.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

extern NSString * const AIJSONSerializationErrorDomain;

typedef NS_ENUM(NSUInteger, AIJSONSerializationError) {
    AIJSONSerializationErrorInvalidType, // Invalid type in JSON write
};

// JSON -> NSDictionary || NSArray
@interface NSJSONSerialization (AIKit)

// NSString From JSON
+ (NSString *)stringFromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;
+ (NSString *)stringFromJSONArray:(NSArray *)JSONArray error:(NSError **)error;
+ (NSString *)stringFromJSON:(id)JSON error:(NSError **)error;

// JSON From NSString
//+ (NSDictionary *)JSONDictionaryFromString:(NSString *)string error:(NSError **)error;
//+ (NSArray *)JSONArrayFromString:(NSString *)string error:(NSError **)error;
//+ (id)JSONFromString:(NSString *)string error:(NSError **)error;

// JSON From id
//+ (NSDictionary *)JSONDictionaryFromResponse:(id)response error:(NSError **)error;

@end
