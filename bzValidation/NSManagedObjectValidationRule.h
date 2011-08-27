//
//  NSManagedObjectValidationRule.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/26/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ValidationRule.h"

typedef enum {
    
    NSManagedObjectValidationRuleTypeNotSet = -1,
    NSManagedObjectValidationInsertRuleType = 0,
    NSManagedObjectValidationUpdateRuleType = 1,
    NSManagedObjectValidationDeleteRuleType = 2
    
} managedObjectvalidationRuleTypes;

@interface NSManagedObjectValidationRule : ValidationRule {
    
}

- (id) initWithManagedObject:(NSManagedObject*)object;

@property (nonatomic, assign) managedObjectvalidationRuleTypes managedObjectvalidationRuleType;

@end
