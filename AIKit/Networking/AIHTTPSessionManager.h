//
//  AIHTTPSessionManager.h
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

#import "AIMantleResponseSerializer.h"

typedef void (^AIHTTPSuccessBlock)(NSURLSessionDataTask *task, id object);
typedef void (^AIHTTPFailureBlock)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSUInteger, AIHTTPMethod) {
    AIHTTPMethodGET,
    AIHTTPMethodPOST,
    AIHTTPMethodPUT,
    AIHTTPMethodPATCH,
    AIHTTPMethodDELETE
};

@interface AIHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, strong, readonly) AIMantleResponseSerializer *mantleResponseSerializer;

- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure;

- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                    modelOfClass:(Class)modelClass
                         inArray:(BOOL)inArray
                          forKey:(NSString *)key
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure;
@end

