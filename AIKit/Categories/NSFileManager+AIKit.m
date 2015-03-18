//
//  NSFileManager+AIKit.m
//  AIKit
//
//  Created by Alexander Ignition on 12.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSFileManager+AIKit.h"

NSString *AIPathForDocumentsDirectory() {
    return AIPathForDirectory(NSDocumentDirectory);
}

NSString *AIPathForDirectory(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
}

@implementation NSFileManager (AIKit)

+ (NSURL *)ai_URLForDocumentDirectory {
    return [self ai_URLForDirectory:NSDocumentDirectory];
}

+ (NSURL *)ai_URLForDirectory:(NSSearchPathDirectory)directory {
    return [[[self defaultManager] URLsForDirectory:directory inDomains:NSUserDomainMask] lastObject];
}

// https://developer.apple.com/library/IOS/qa/qa1719/_index.html
+ (BOOL)ai_addSkipBackupAttributeToItemAtURL:(NSURL *)URL error:(NSError **)outError {
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    return [URL setResourceValue: @YES forKey: NSURLIsExcludedFromBackupKey error:outError];
}

+ (NSNumber *)ai_sizeOfFileAtPath:(NSString *)path error:(NSError **)error {
    NSDictionary *dict = [[self defaultManager] attributesOfItemAtPath:path error:error];
    return (error) ? nil : dict[NSFileSize];
}

@end
