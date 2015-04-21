//
//  AIHTTPSessionManager.m
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "AIHTTPSessionManager.h"

@implementation AIHTTPSessionManager

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

@end
