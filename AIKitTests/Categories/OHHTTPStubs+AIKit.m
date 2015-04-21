//
//  OHHTTPStubs+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "OHHTTPStubs+AIKit.h"

void (^stubResponseWithHeaders)(NSString *, NSString *, NSDictionary *) = ^(NSString *path, NSString *responseFilename, NSDictionary *headers) {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSString *path = [[NSBundle bundleForClass:[OHHTTPStubs class]] pathForResource:[responseFilename stringByDeletingPathExtension] ofType:[responseFilename pathExtension]];
        return [OHHTTPStubsResponse responseWithFileAtPath:path statusCode:200 headers:headers];
    }];
};

void (^stubResponse)(NSString *, NSString *) = ^(NSString *path, NSString *responseFilename) {
    stubResponseWithHeaders(path, responseFilename, @{@"content-type": @"application/json"});
};

void (^stubResponseWithStatusCode)(NSString *, int) = ^(NSString *path, int statusCode) {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:[NSData data] statusCode:statusCode headers:@{@"content-type": @"application/json"}];
    }];
};

#pragma mark - JSON

void (^stubResponseWithTaskAndFile)(NSURLSessionDataTask *, NSString *) = ^(NSURLSessionDataTask *task, NSString *responseFilename) {
    NSString *path = task.currentRequest.URL.path;
    stubResponse(path, responseFilename);
};

void (^stubResponseWithTaskAndJSON)(NSURLSessionDataTask *, NSDictionary *) = ^(NSURLSessionDataTask *task, NSDictionary *JSON) {
    NSString *path = task.currentRequest.URL.path;
    stubResponseWithJSON(path, JSON);
};

void (^stubResponseWithJSON)(NSString *, NSDictionary *) = ^(NSString *path, NSDictionary *JSON) {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSData *adta = [NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil];
        return [OHHTTPStubsResponse responseWithData:adta statusCode:200 headers:@{@"content-type": @"application/json"}];
    }];
};

#pragma mark - Error

void (^stubResponseWithTaskAndNotConnectedError)(NSURLSessionDataTask *) = ^(NSURLSessionDataTask *task) {
    NSError *notConnectedError = [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:nil];
    stubResponseWithTaskAndError(task, notConnectedError);
};

void (^stubResponseWithTaskAndError)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
    NSString *path = task.currentRequest.URL.path;
    stubResponseWithError(path, error);
};

void (^stubResponseWithError)(NSString *, NSError *) = ^(NSString *path, NSError *error) {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithError:error];
    }];
};