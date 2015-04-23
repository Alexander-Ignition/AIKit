//
//  AIHTTPSessionManager.m
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "AIHTTPSessionManager.h"
#import "AIMantleResponseSerializer.h"

@implementation AIHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        
        _mantleResponseSerializer = [AIMantleResponseSerializer serializer];
        self.responseSerializer = self.mantleResponseSerializer;
    }
    return self;
}

- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure
{
    switch (method) {
        case AIHTTPMethodGET:
            return [self GET:URLString parameters:parameters success:success failure:failure];
            
        case AIHTTPMethodPOST:
            return [self POST:URLString parameters:parameters success:success failure:failure];
            
        case AIHTTPMethodPUT:
            return [self PUT:URLString parameters:parameters success:success failure:failure];
            
        case AIHTTPMethodPATCH:
            return [self PATCH:URLString parameters:parameters success:success failure:failure];
            
        case AIHTTPMethodDELETE:
            return [self DELETE:URLString parameters:parameters success:success failure:failure];
            
        default:
            return [self GET:URLString parameters:parameters success:success failure:failure];
    }
}

- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                    modelOfClass:(Class)modelClass
                         inArray:(BOOL)inArray
                          forKey:(NSString *)key
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure;
{
    __weak __typeof(self)weakSelf = self;
    return [self method:method
              URLString:URLString
             parameters:parameters
                success:^(NSURLSessionDataTask *task, id object) {
                    
                    [weakSelf.mantleResponseSerializer parse:object
                                                       model:modelClass
                                                     inArray:inArray
                                                      forKey:key
                                                        task:task
                                                     success:success
                                                     failure:failure];
                } failure:failure];
}

@end

