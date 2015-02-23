//
//  NSDictioanry+AIKitTests.m
//  AIKit
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDictionary+AIKit.h"


@interface NSDictioanry_AIKitTests : XCTestCase
@property (strong, nonatomic) NSDictionary *JSON;
@end


@implementation NSDictioanry_AIKitTests

- (NSDictionary *)JSON {
    if (!_JSON) {
        return @{ @"number" : @5,
                  @"string" : @"sring",
                  @"null"   : [NSNull null],
                  @"array"  : @[ @1, @6, @18 ],
                  @"dict"   : @{ @"k1" : @2, @"k2" : @3} };
    }
    return _JSON;
}

- (void)testAi_objectForKey {
    XCTAssert([self.JSON ai_objectForKey:@"number"]);
    XCTAssert([self.JSON ai_objectForKey:@"string"]);
    XCTAssertNil([self.JSON ai_objectForKey:@"null"]);
}

- (void)testAi_objectForKeyKindOfClass {
    XCTAssert([self.JSON ai_objectForKey:@"number" kindOfClass:[NSNumber class]]);
    XCTAssertNil([self.JSON ai_objectForKey:@"string" kindOfClass:[NSArray class]]);
    XCTAssertNil([self.JSON ai_objectForKey:@"null" kindOfClass:[NSDictionary class]]);
}

- (void)testAi_stringForKey {
    XCTAssert([self.JSON ai_stringForKey:@"string"]);
    XCTAssertNil([self.JSON ai_stringForKey:@"number"]);
}

- (void)testAi_numberForKey {
    XCTAssert([self.JSON ai_numberForKey:@"number"]);
    XCTAssertNil([self.JSON ai_numberForKey:@"string"]);
}

- (void)testAi_arrayForKey {
    XCTAssert([self.JSON ai_arrayForKey:@"array"]);
    XCTAssertNil([self.JSON ai_arrayForKey:@"string"]);
}

- (void)testAi_dictionaryForKey {
    XCTAssert([self.JSON ai_dictionaryForKey:@"dict"]);
    XCTAssertNil([self.JSON ai_dictionaryForKey:@"string"]);
}

@end
