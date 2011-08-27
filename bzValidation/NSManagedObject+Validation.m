//
//  NSManagedObject+PrettyErrors.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/26/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "NSManagedObject+Validation.h"

@interface NSManagedObject()

- (NSString*)stringForError:(NSError*)error;
- (NSArray*) breakUpErrors:(NSError*)error;

@end

@implementation NSManagedObject (Validation)

/*
 NSManagedObjectValidationError                   = 1550,   // generic validation error
 NSValidationMultipleErrorsError                  = 1560,   // generic message for error containing multiple validation errors
 NSValidationMissingMandatoryPropertyError        = 1570,   // non-optional property with a nil value
 NSValidationRelationshipLacksMinimumCountError   = 1580,   // to-many relationship with too few destination objects
 NSValidationRelationshipExceedsMaximumCountError = 1590,   // bounded, to-many relationship with too many destination objects
 NSValidationRelationshipDeniedDeleteError        = 1600,   // some relationship with NSDeleteRuleDeny is non-empty
 NSValidationNumberTooLargeError                  = 1610,   // some numerical value is too large
 NSValidationNumberTooSmallError                  = 1620,   // some numerical value is too small
 NSValidationDateTooLateError                     = 1630,   // some date value is too late
 NSValidationDateTooSoonError                     = 1640,   // some date value is too soon
 NSValidationInvalidDateError                     = 1650,   // some date value fails to match date pattern
 NSValidationStringTooLongError                   = 1660,   // some string value is too long
 NSValidationStringTooShortError                  = 1670,   // some string value is too short
 NSValidationStringPatternMatchingError           = 1680,   // some string value fails to match some pattern
 
 NSManagedObjectContextLockingError               = 132000, // can't acquire a lock in a managed object context
 NSPersistentStoreCoordinatorLockingError         = 132010, // can't acquire a lock in a persistent store coordinator
 
 NSManagedObjectReferentialIntegrityError         = 133000, // attempt to fire a fault pointing to an object that does not exist (we can see the store, we can't see the object)
 NSManagedObjectExternalRelationshipError         = 133010, // an object being saved has a relationship containing an object from another store
 NSManagedObjectMergeError                        = 133020, // merge policy failed - unable to complete merging
 
 NSPersistentStoreInvalidTypeError                = 134000, // unknown persistent store type/format/version
 NSPersistentStoreTypeMismatchError               = 134010, // returned by persistent store coordinator if a store is accessed that does not match the specified type
 NSPersistentStoreIncompatibleSchemaError         = 134020, // store returned an error for save operation (database level errors ie missing table, no permissions)
 NSPersistentStoreSaveError                       = 134030, // unclassified save error - something we depend on returned an error
 NSPersistentStoreIncompleteSaveError             = 134040, // one or more of the stores returned an error during save (stores/objects that failed will be in userInfo)
 
 NSCoreDataError                                  = 134060, // general Core Data error
 NSPersistentStoreOperationError                  = 134070, // the persistent store operation failed 
 NSPersistentStoreOpenError                       = 134080, // an error occured while attempting to open the persistent store
 NSPersistentStoreTimeoutError                    = 134090, // failed to connect to the persistent store within the specified timeout (see NSPersistentStoreTimeoutOption)
 
 NSPersistentStoreIncompatibleVersionHashError    = 134100, // entity version hashes incompatible with data model
 NSMigrationError                                 = 134110, // general migration error
 NSMigrationCancelledError                        = 134120, // migration failed due to manual cancellation
 NSMigrationMissingSourceModelError               = 134130, // migration failed due to missing source data model
 NSMigrationMissingMappingModelError              = 134140, // migration failed due to missing mapping model
 NSMigrationManagerSourceStoreError               = 134150, // migration failed due to a problem with the source data store
 NSMigrationManagerDestinationStoreError          = 134160, // migration failed due to a problem with the destination data store
 NSEntityMigrationPolicyError                     = 134170, // migration failed during processing of the entity migration policy 
 
 NSSQLiteError                                    = 134180  // general SQLite error 
 
 , NSInferredMappingModelError                      = 134190 // inferred mapping model creation error
 , NSExternalRecordImportError                      = 134200 // general error encountered while importing external records
 */

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Public Methods

- (BOOL) insertValidationResultWithErrorStrings:(NSArray **)errorStrings {
    
    NSError *error = nil;
    
    NSMutableArray *errorsArray = [NSMutableArray array];
    
    BOOL valid = [self validateForInsert:&error];
    
    if (!valid && error != nil) {
        
        NSArray *errors = [self breakUpErrors:error];
        
        for (NSError *err in errors) {
            
            [errorsArray addObject:[self stringForError:err]];
        }        
    } 
    
    *errorStrings = errorsArray;
    
    return valid;
}

- (BOOL) updateValidationResultWithErrorStrings:(NSArray **)errorStrings {
    
    NSError *error = nil;
    
    NSMutableArray *errorsArray = [NSMutableArray array];
    
    BOOL valid = [self validateForUpdate:&error];
    
    if (!valid && error != nil) {
        
        NSArray *errors = [self breakUpErrors:error];
        
        for (NSError *err in errors) {
            
            [errorsArray addObject:[self stringForError:err]];
        }        
    } 
    
    *errorStrings = errorsArray;
    
    return valid;
}

- (BOOL) deleteValidationResultWithErrorStrings:(NSArray **)errorStrings {
    
    NSError *error = nil;
    
    NSMutableArray *errorsArray = [NSMutableArray array];
    
    BOOL valid = [self validateForDelete:&error];
    
    if (!valid && error != nil) {
        
        NSArray *errors = [self breakUpErrors:error];
        
        for (NSError *err in errors) {
            
            [errorsArray addObject:[self stringForError:err]];
        }        
    } 
    
    *errorStrings = errorsArray;
    
    return valid;
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Utility Methods

- (NSArray*) breakUpErrors:(NSError *)error {
    
    NSMutableArray *errors = [NSMutableArray array];
    
    if ([error code] == NSValidationMultipleErrorsError) {
        
        [errors addObjectsFromArray:[error.userInfo objectForKey:NSDetailedErrorsKey]];
        
    } else {
        
        [errors addObject:error];
    }
    
    return errors;
}

- (NSString *)stringForError:(NSError*)error {

    NSString *errorString = nil;
    
    NSString *className = NSStringFromClass([self class]);
    
    NSInteger errorCode = [error code];
    
    NSDictionary *userInfo = [error userInfo];
    
    NSString *offendingField = [userInfo objectForKey:NSValidationKeyErrorKey];
    NSObject *offendingValue = [userInfo objectForKey:NSValidationValueErrorKey];
    
    switch (errorCode) {
            
        case NSValidationMissingMandatoryPropertyError: 
            errorString = [NSString stringWithFormat:@"%@ is missing %@ which is a required property", className, offendingField];
            break;
        case NSValidationNumberTooLargeError:
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ exceeds the maximum allowed", className, offendingField, offendingValue];
            break;
        case NSValidationNumberTooSmallError:    
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ does not meet the minimum allowed", className, offendingField, offendingValue];
            break;
        case NSValidationDateTooLateError:
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ is later than allowed", className, offendingField, offendingValue];
            break;
        case NSValidationDateTooSoonError:
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ is earlier than allowed", className, offendingField, offendingValue];
            break;
        case NSValidationInvalidDateError:
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ is not a valid date", className, offendingField, offendingValue];
            break;
        case NSValidationStringTooLongError:
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ is too long", className, offendingField, offendingValue];
            break;
        case NSValidationStringTooShortError:
            errorString = [NSString stringWithFormat:@"%@'s %@ value of %@ is too short", className, offendingField, offendingValue];
            break;
        default:
            errorString = @"General Validation Error";
            break;
    }
    
    return errorString;
}

@end
