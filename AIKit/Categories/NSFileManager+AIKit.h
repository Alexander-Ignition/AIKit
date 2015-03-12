//
//  NSFileManager+AIKit.h
//  AIKit
//
//  Created by Alexander Ignition on 12.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

FOUNDATION_EXPORT NSString *AIPathForDocumentsDirectory();
FOUNDATION_EXPORT NSString *AIPathForDirectory(NSSearchPathDirectory directory);

@interface NSFileManager (AIKit)

+ (NSURL *)ai_URLForDocumentDirectory;
+ (NSURL *)ai_URLForDirectory:(NSSearchPathDirectory)directory;

+ (BOOL)ai_addSkipBackupAttributeToItemAtURL:(NSURL *)URL error:(NSError **)outError;

@end
