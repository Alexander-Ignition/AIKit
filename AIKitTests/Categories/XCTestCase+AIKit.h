//
//  XCTestCase+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OHHTTPStubs+AIKit.h"

@interface XCTestCase (AIKit)

- (void)expectationWithDescription:(NSString *)description
                    performAndWait:(void (^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler;

- (void)expectationWithDescription:(NSString *)description
                           timeout:(NSTimeInterval)timeout
                    performAndWait:(void (^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler;

- (void)expectationWithDescription:(NSString *)description
                              JSON:(NSDictionary *)JSON
                    performAndWait:(NSURLSessionDataTask *(^)(XCTestExpectation *expectation))block
                           handler:(void (^)(NSError *error))handler;
@end
