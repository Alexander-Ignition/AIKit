//
//  AIHTTPSessionManager.h
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@class AIMantleResponseSerializer;

typedef void (^AIHTTPSuccessBlock)(NSURLSessionDataTask *task, id model);
typedef void (^AIHTTPFailureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^AIHTTPSuccessArrayBlock)(NSURLSessionDataTask *task, NSArray *models);

typedef NS_ENUM(NSUInteger, AIHTTPMethod) {
    AIHTTPMethodGET,
    AIHTTPMethodPOST,
    AIHTTPMethodPUT,
    AIHTTPMethodPATCH,
    AIHTTPMethodDELETE
};

@interface AIHTTPSessionManager : AFHTTPSessionManager

/*!
 @brief Серилизатор JSON в объекты MTLModel
 */
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
                          forKey:(NSString *)key
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure;

- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                   modelsOfClass:(Class)modelClass
                          forKey:(NSString *)key
                         success:(AIHTTPSuccessArrayBlock)success
                         failure:(AIHTTPFailureBlock)failure;
@end

