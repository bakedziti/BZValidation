//
//  bzValidationTests.m
//  bzValidationTests
//
//  Created by Joseph DeCarlo on 8/27/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "bzValidationTests.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "NSManagedObject+Validation.h"

@interface bzValidationTests()

@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSPersistentStore *persistentStore;

@end

@implementation bzValidationTests

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize persistentStore = _persistentStore;

- (void)setUp
{
    [super setUp];    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *modelURL = [bundle URLForResource:@"bzValidationModel" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    

//    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles: nil];
    NSLog(@"model: %@", self.managedObjectModel);
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel];
    self.persistentStore = [self.persistentStoreCoordinator addPersistentStoreWithType: NSInMemoryStoreType
                                configuration: nil
                                          URL: nil
                                      options: nil 
                                        error: NULL];
    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator: self.persistentStoreCoordinator];
}

- (void)tearDown
{

    [self.managedObjectContext release];
    self.managedObjectContext = nil;
    NSError *error = nil;
    STAssertTrue([self.persistentStoreCoordinator removePersistentStore: self.persistentStore error: &error], 
                 @"couldn't remove persistent store: %@", error);
    self.persistentStore = nil;
    [self.persistentStoreCoordinator release];
    self.persistentStoreCoordinator = nil;
    [self.managedObjectModel release];
    self.managedObjectModel = nil;
    
    [super tearDown];
}


- (void) testNSManagedObject {
    

    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    
    [self.managedObjectContext save:&error];
    
    person.FirstName = @"Joseph";
    person.LastName = @"DeCarlo";
    
    NSArray *errorMessages = nil;

    [person preValidateForUpdate:&errorMessages];

}

- (void) testTwo {
    
}

- (void) testThree {
    
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Core Data

//- (NSManagedObjectContext*) managedObjectContext {
//    
//    if (_managedObjectContext != nil) {
//        
//        return _managedObjectContext;
//    }
//    
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    
//    if (coordinator != nil) {
//        
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
//    
//    return _managedObjectContext;
//}
//
//- (NSManagedObjectModel*) managedObjectModel {
//    
//    if (_managedObjectModel != nil) {
//        
//        return _managedObjectModel;
//    }
//    
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"bzValidationModel" withExtension:@"momd"];
//    
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    
//    return _managedObjectModel;
//}
//
//- (NSPersistentStoreCoordinator*) persistentStoreCoordinator {
//    
//    if (_persistentStoreCoordinator != nil) {
//        
//        return _persistentStoreCoordinator;
//    }
//    
//    NSURL *docDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    
//    NSURL *storeURL = [docDirectory URLByAppendingPathComponent:@"bzValidationModel.sqlite"];
//    
//    NSError *error = nil;
//    
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//        
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }    
//    
//    return _persistentStoreCoordinator;
//
//}

@end
