//
//  OHHTTPStubs+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "OHHTTPStubs.h"

void (^stubResponseWithHeaders)(NSString *, NSString *, NSDictionary *);
void (^stubResponse)(NSString *, NSString *);
void (^stubResponseWithStatusCode)(NSString *, int);

void (^stubResponseWithTaskAndFile)(NSURLSessionDataTask *task, NSString *responseFilename);
void (^stubResponseWithTaskAndJSON)(NSURLSessionDataTask *task, NSDictionary *JSON);
void (^stubResponseWithJSON)(NSString *path, NSDictionary *JSON);

void (^stubResponseWithTaskAndNotConnectedError)(NSURLSessionDataTask *task);
void (^stubResponseWithTaskAndError)(NSURLSessionDataTask *task, NSError *error);
void (^stubResponseWithError)(NSString *path, NSError *error);
