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
typedef NSError * (^AISerializerHandlerBlock)(NSURLResponse *response, id JSON);

typedef NS_ENUM(NSUInteger, AIResponseType) {
    AIResponseTypeJSON,
    AIResponseTypeArray,
    AIResponseTypeDictionary,
};

@interface AIMantleResponseSerializer : AFJSONResponseSerializer

@property (nonatomic, strong) dispatch_queue_t dispatch_queue;
@property (nonatomic, assign) AIResponseType responseType;
@property (nonatomic, copy) AISerializerHandlerBlock responseHandler;

- (void)parseJSON:(id)JSON
           forKey:(NSString *)key
          inModel:(Class)modelClass
          inArray:(BOOL)inArray
             task:(NSURLSessionDataTask *)task
          success:(AISerializerAnyBlock)success
          failure:(AISerializerErrorBlock)failure;

@end
