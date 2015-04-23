//
//  AIMantleResponseSerializer.h
//  AIKit
//
//  Created by Alexander Ignition on 22.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <AFNetworking/AFURLResponseSerialization.h>

typedef void (^AISerializerAnyBlock)(NSURLSessionDataTask *task, id object);
typedef void (^AISerializerErrorBlock)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSUInteger, AIResponseType) {
    AIResponseTypeJSON,
    AIResponseTypeArray,
    AIResponseTypeDictionary,
};

@interface AIMantleResponseSerializer : AFJSONResponseSerializer

@property (nonatomic, strong) dispatch_queue_t dispatch_queue;

@property (nonatomic, assign) AIResponseType responseType;

- (void)parse:(id)object
        model:(Class)model
      inArray:(BOOL)inArray
       forKey:(NSString *)key
         task:(NSURLSessionDataTask *)task
      success:(AISerializerAnyBlock)success
      failure:(AISerializerErrorBlock)failure;

- (void)parse:(id)object
        model:(Class)model
      inArray:(BOOL)inArray
         task:(NSURLSessionDataTask *)task
      success:(AISerializerAnyBlock)success
      failure:(AISerializerErrorBlock)failure;

@end
