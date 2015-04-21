//
//  XCTestCase+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "XCTestCase+AIKit.h"

static const NSTimeInterval DefaultTimeout = 65.f;

@implementation XCTestCase (AIKit)

- (void)expectationWithDescription:(NSString *)description
                    performAndWait:(void (^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler
{
    [self expectationWithDescription:description
                             timeout:DefaultTimeout
                      performAndWait:block
                             handler:handler];
}

- (void)expectationWithDescription:(NSString *)description
                           timeout:(NSTimeInterval)timeout
                    performAndWait:(void (^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler
{
    block([self expectationWithDescription:description]);
    [self waitForExpectationsWithTimeout:timeout handler:handler];
}

#pragma mark - NSURLSessionDataTask

- (void)expectationWithDescription:(NSString *)description
                              JSON:(NSDictionary *)JSON
                    performAndWait:(NSURLSessionDataTask *(^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler
{
    NSURLSessionDataTask *task = block([self expectationWithDescription:description]);
    stubResponseWithTaskAndJSON(task, JSON);
    [self waitForExpectationsWithTimeout:DefaultTimeout handler:handler];
}

#pragma mark - Error

- (void)expectationWithResponseErrorDescription:(NSString *)description
                                 performAndWait:(NSURLSessionDataTask *(^)(XCTestExpectation *expectation))block
                                        handler:(void (^)(NSError *error))handler
{
    NSURLSessionDataTask *task = block([self expectationWithDescription:description]);
    stubResponseWithTaskAndNotConnectedError(task);
    [self waitForExpectationsWithTimeout:DefaultTimeout handler:handler];
}

- (void)expectationWithDescription:(NSString *)description
                     responseError:(NSError *)error
                    performAndWait:(NSURLSessionDataTask *(^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler
{
    NSURLSessionDataTask *task = block([self expectationWithDescription:description]);
    stubResponseWithTaskAndError(task, error);
    [self waitForExpectationsWithTimeout:DefaultTimeout handler:handler];
}

@end
