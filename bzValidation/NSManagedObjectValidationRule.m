//
//  NSManagedObjectValidationRule.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/26/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "NSManagedObjectValidationRule.h"
#import "NSManagedObject+Validation.h"

@interface NSManagedObjectValidationRule()

@property (nonatomic, retain) NSManagedObject *managedObject;

@end

@implementation NSManagedObjectValidationRule

@synthesize managedObject;
@synthesize managedObjectvalidationRuleType;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation

- (id) initWithManagedObject:(NSManagedObject*)object {
    
    id weakSelf = [self init];
    
    if (weakSelf) {
        
        self.managedObject = object;
        self.managedObjectvalidationRuleType = NSManagedObjectValidationRuleTypeNotSet;
    }
    
    return weakSelf;
}

- (void)dealloc {
    
    self.managedObject = nil;
    self.managedObjectvalidationRuleType = NSManagedObjectValidationRuleTypeNotSet;
    
    [super dealloc];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - ValidationRule

- (BOOL) validateWithMessages:(NSArray **)errorMessages {
    
    BOOL valid = YES;
    
    NSArray *messages = nil;
    
    switch (self.managedObjectvalidationRuleType) {
        case NSManagedObjectValidationUpdateRuleType:
            valid = [self.managedObject updateValidationResultWithErrorStrings:&messages];
            break;
        case NSManagedObjectValidationInsertRuleType:
            valid = [self.managedObject insertValidationResultWithErrorStrings:&messages];
            break;
        case NSManagedObjectValidationDeleteRuleType:
            valid = [self.managedObject deleteValidationResultWithErrorStrings:&messages];
            break;
        case NSManagedObjectValidationRuleTypeNotSet:
        default:
            [NSException raise:@"NSManagedObjectValidationRuleType Not Set" format:@"Must set NSManagedObjectValidationRuleType before calling validate"];
            valid = NO;
            break;
    }
    
    *errorMessages = messages;
    
    return valid;
}



@end
