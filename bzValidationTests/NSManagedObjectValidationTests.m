//
//  NSManagedObjectValidationTests.m
//  bzValidationTests
//
//  Created by Joseph DeCarlo on 8/27/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "NSManagedObjectValidationTests.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "NSManagedObject+Validation.h"

@interface NSManagedObjectValidationTests()

@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSPersistentStore *persistentStore;

@end

@implementation NSManagedObjectValidationTests

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
//    NSLog(@"model: %@", self.managedObjectModel);
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


- (void) testNSManagedObjectMaximumNumberExceededForUpdate {
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    
    [self.managedObjectContext save:&error];
    
    person.FirstName = @"Joseph";
    person.LastName = @"DeCarlo";
    person.Age = [NSNumber numberWithInt:130];
    
    NSArray *errorMessages = nil;

    BOOL result = [person preValidateForUpdate:&errorMessages];
    
    STAssertFalseNoThrow(result, @"Validation should have flagged Person.Age as exceeding maximum age");
    STAssertTrue(([errorMessages count] == 1),  @"Validation should have only had 1 validation error reported");
}

- (void) testNSManagedObjectMinimumLengthNotMetForUpdate {
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    
    [self.managedObjectContext save:&error];
    
    person.FirstName = @"A";
    person.LastName = @"LastName";
    
    NSArray *errorMessages = nil;
    
    BOOL result = [person preValidateForUpdate:&errorMessages];
    
    STAssertFalseNoThrow(result, @"Validation should have flagged Person.FirstName as not meeting the minimum requirement");
    STAssertTrue(([errorMessages count] == 1), @"Validation should have only had 1 validation error reported");
}

- (void) testNSManagedObjectMaximumNumberExceededForInsert {
    
    Person * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    person.FirstName = @"Joseph";
    person.LastName = @"DeCarlo";
    person.Age = [NSNumber numberWithInt:130];
    
    NSArray *errorMessages = nil;
    
    BOOL result = [person preValidateForInsert:&errorMessages];
    
    STAssertFalseNoThrow(result, @"Validation should have flagged Person.Age as exceeding the maximum age");
    STAssertTrue([errorMessages count] == 1, @"Validation should only have 1 validation error reported");
}

- (void) testNSManagedObjectMinimumLengthNotMetForInsert {
    
    Person * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    person.FirstName = @"A";
    person.LastName = @"DeCarlo";
    person.Age = [NSNumber numberWithInt:5];
    
    NSArray *errorMessages = nil;
    
    BOOL result = [person preValidateForInsert:&errorMessages];
    
    STAssertFalseNoThrow(result, @"Validation should have flagged Person.FirstName as not meeting the minimum requirement");
    STAssertTrue(([errorMessages count] == 1), @"Validation should have only had 1 validation error reported");
}

- (void) testNSManagedObjectMultipleErrorsForUpdate {
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    
    [self.managedObjectContext save:&error];
    
    person.FirstName = @"A";
    person.LastName = @"DeCarlo";
    person.Age = [NSNumber numberWithInt:130];
    
    NSArray *errorMessages = nil;
    
    BOOL result = [person preValidateForUpdate:&errorMessages];
    
    STAssertFalseNoThrow(result, @"Validation should have flagged Person.FirstName and Person.Age as errors");
    STAssertTrue(([errorMessages count] == 2),  @"Validation should have had 2 validation errors reported");
}

- (void) testNSManagedObjectMultipleErrorsForInsert {
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    person.FirstName = @"A";
    person.LastName = @"DeCarlo";
    person.Age = [NSNumber numberWithInt:130];
    
    NSArray *errorMessages = nil;
    
    BOOL result = [person preValidateForInsert:&errorMessages];
    
    STAssertFalseNoThrow(result, @"Validation should have flagged Person.FirstName and Person.Age as errors");
    STAssertTrue(([errorMessages count] == 2),  @"Validation should have had 2 validation errors reported");
}

@end
