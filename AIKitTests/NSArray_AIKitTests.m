//
//  NSArray_AIKitTests.m
//  AIKit
//
//  Created by Александр Игнатьев on 15.05.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+AIKit.h"

@interface NSArray_AIKitTests : XCTestCase

@end

@implementation NSArray_AIKitTests {
    NSArray *_array;
    NSUInteger _count;
}

- (void)setUp {
    [super setUp];
    
    _array = @[ @4,
                @5,
                @"test_item",
                [NSNull null],
                @"item",
                @7,
                [NSNull null],
                @[@0, @6],
                @[@"t", @"i"] ];
    _count = 0;
}

#pragma mark - Map

- (void)testAi_numberMap {
    NSArray *array = [_array ai_numberMap:^id(NSNumber *number) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Not valid class");
        return number;
    }];
    XCTAssertEqual(array.count, 3, @"The array contains only three number");
}

- (void)testAi_stringMap {
    NSArray *array = [_array ai_stringMap:^id(NSString *string) {
        XCTAssert([string isKindOfClass:[NSString class]], @"Not valid class");
        return string;
    }];
    XCTAssertEqual(array.count, 2, @"The array contains only 2 string");
}

- (void)testAi_arrayMap {
    NSArray *array = [_array ai_arrayMap:^id(NSArray *ar) {
        XCTAssert([ar isKindOfClass:[NSArray class]], @"Not valid class");
        return ar;
    }];
    XCTAssertEqual(array.count, 2, @"The array contains only 2 array");
}

- (void)testAi_filterIsKindOfClassMap {
    Class aClass = [NSNull class];
    NSArray *array = [_array ai_objectsOfClass:aClass map:^id(id object) {
        XCTAssert([object isKindOfClass:aClass], @"Not valid class");
        return @1;
    }];
    XCTAssertEqual(array.count, 2, @"The array contains only 2 array");
    for (id obj in array) {
        XCTAssertEqualObjects(obj, @1);
    }
}

- (void)testAi_filterMap {
    NSArray *array = [_array ai_filter:^BOOL(id object) {
        return [object respondsToSelector:@selector(count)];
    } map:^id(id object) {
        return @([object count]);
    }];
    NSArray *array2 = @[ @2, @2 ];
    XCTAssertEqualObjects(array, array2);
}

#pragma mark - Object at Index

- (void)testAi_numberAtIndex {
    XCTAssertEqualObjects([_array ai_numberAtIndex:0], @4);
    XCTAssertNil([_array ai_numberAtIndex:2]);
}

- (id)ai_objectAtIndexIsKindOfClass {
    XCTAssertEqualObjects([_array ai_objectAtIndex:2 ofClass:[NSString class]], @"test_item");
    XCTAssertNil([_array ai_objectAtIndex:3 ofClass:[NSString class]]);
}

#pragma mark - Enumerate

- (void)testAi_predicateEnumerate {
    __block NSUInteger count = 0;
    [_array ai_predicate:^BOOL(id obj) {
        return [obj respondsToSelector:@selector(count)];
    } enumerate:^(id obj, NSUInteger idx, BOOL *stop) {
        ++count;
    }];
    XCTAssertEqual(count, 2);
}

- (void)testAi_predicateEnumerateStop {
    NSMutableArray *ar = [NSMutableArray arrayWithCapacity:100];
    for (NSUInteger i = 0; i < 100; i++) {
        [ar addObject:@(i)];
    }
    
    NSUInteger stopIndex = 59;
    __block NSUInteger count = 0;
    [ar ai_predicate:^BOOL(id obj) {
        return [obj isKindOfClass:[NSNumber class]];
    } enumerate:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == stopIndex) {
            *stop = YES;
        } else {
            ++count;
        }
    }];
    XCTAssertEqual(count, stopIndex);
}

@end
