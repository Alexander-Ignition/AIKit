//
//  NSJSONSerialization_AIKitTests.m
//  AIKit
//
//  Created by Alexander Ignition on 24.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSJSONSerialization+AIKit.h"

@interface NSJSONSerialization_AIKitTests : XCTestCase

@end

@implementation NSJSONSerialization_AIKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringFromJSON {
    NSError *error;
    NSString *JSONString = [NSJSONSerialization stringFromJSON:@"dvdfbfdb" error:&error];
    XCTAssert(JSONString);
    XCTAssertNil(error);
}

- (void)testStringFromJSONFail {
    NSError *error;
    NSString *JSONString = [NSJSONSerialization stringFromJSON:@"dvdfbfdb" error:&error];
    XCTAssertNil(JSONString);
    XCTAssertEqualObjects(error.domain, AIJSONSerializationErrorDomain);
    XCTAssertEqual(error.code, AIJSONSerializationErrorInvalidType);
}

@end
