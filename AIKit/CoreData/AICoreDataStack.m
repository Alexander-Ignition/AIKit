//
//  AICoreDataStack.m
//  AIKit
//
//  Created by Alexander Ignition on 01.06.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "AICoreDataStack.h"

static NSString * const kOGCoreDataModelFileName = @"Model";
static NSString * const kOGCoreDataStoreFileName = @"Store";


@interface AICoreDataStack ()

@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (strong, nonatomic) NSManagedObjectContext *mainQueueContext;
@property (strong, nonatomic) NSManagedObjectContext *privateQueueContext;

@end


@implementation AICoreDataStack

- (instancetype)initWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL {
    return nil;
}

- (instancetype)init {
    if (self = [super init]) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self
                   selector:@selector(contextDidSavePrivateQueueContext:)
                       name:NSManagedObjectContextDidSaveNotification
                     object:self.privateQueueContext];
        
        [center addObserver:self
                   selector:@selector(contextDidSaveMainQueueContext:)
                       name:NSManagedObjectContextDidSaveNotification
                     object:self.mainQueueContext];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Notifications

- (void)contextDidSavePrivateQueueContext:(NSNotification *)notification {
    @synchronized(self) {
        [self.mainQueueContext performBlock:^{
            [self.mainQueueContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

- (void)contextDidSaveMainQueueContext:(NSNotification *)notification {
    @synchronized(self) {
        [self.privateQueueContext performBlock:^{
            [self.privateQueueContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}


#pragma mark - Context

- (NSManagedObjectContext *)mainQueueContext {
    if (!_mainQueueContext) {
        _mainQueueContext = [self contextConcurrencyType:NSMainQueueConcurrencyType];
    }
    return _mainQueueContext;
}

- (NSManagedObjectContext *)privateQueueContext {
    if (!_privateQueueContext) {
        _privateQueueContext = [self contextConcurrencyType:NSPrivateQueueConcurrencyType];
    }
    return _privateQueueContext;
}

- (NSManagedObjectContext *)contextConcurrencyType:(NSManagedObjectContextConcurrencyType)ct {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:ct];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return context;
}


#pragma mark - Stack Setup

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSDictionary *persistentStoreOptions = [self persistentStoreOptions];
        NSURL *persistentStoreURL = [self persistentStoreURL];
        NSError *error = nil;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:persistentStoreURL options:persistentStoreOptions error:&error]) {
            NSLog(@"Error adding persistent store. %@", error);
            
            [[NSFileManager defaultManager] removeItemAtURL:persistentStoreURL error:nil];
            [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:persistentStoreURL options:nil error:&error];
            NSLog(@"Перезапись SQLite файла, из-за изменений в CoreData Model (%@.xcdatamodeld)", kOGCoreDataModelFileName);
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kOGCoreDataModelFileName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSURL *)persistentStoreURL {
    NSString *file = [NSString stringWithFormat:@"%@.sqlite", kOGCoreDataStoreFileName];
    NSURL *storeURL= [[self applicationDocumentsDirectory] URLByAppendingPathComponent:file];
    return storeURL;
}

- (NSDictionary *)persistentStoreOptions {
    return @{
             NSInferMappingModelAutomaticallyOption: @YES,
             NSMigratePersistentStoresAutomaticallyOption: @YES,
             NSSQLitePragmasOption: @{ @"synchronous": @"OFF" }
             };
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
