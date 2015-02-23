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


@end
