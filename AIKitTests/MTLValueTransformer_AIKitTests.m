//
//  MTLValueTransformer_AIKitTests.m
//  AIKit
//
//  Created by Alexander Ignition on 15.05.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MTLValueTransformer+AIKit.h"

@interface MTLValueTransformer_AIKitTests : XCTestCase

@end

@implementation MTLValueTransformer_AIKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testAi_valueTransformerWithEnumDefaultValue {
    NSArray *aEnum = @[ @0, @1, @2 ];
    NSValueTransformer *transformer = [NSValueTransformer ai_valueTransformerWithEnum:aEnum defaultValue:@0];
    XCTAssert(transformer, @"Не создан NSValueTransformer");
    XCTAssertEqual([transformer transformedValue:@4], @0, @"Значение вышело за границы возможных значений");
    XCTAssertEqual([transformer transformedValue:@1], @1, @"Не верная трансформация");
    XCTAssertEqual([transformer reverseTransformedValue:@(-4)], @0, @"Значение вышело за границы возможных значений");
    XCTAssertEqual([transformer reverseTransformedValue:@2], @2, @"Не верная трансформация");
}

@end
