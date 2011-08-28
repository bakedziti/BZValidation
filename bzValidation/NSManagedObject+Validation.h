//
//  NSManagedObject+PrettyErrors.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/26/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ValidationIncludes.h"


@interface NSManagedObject (Validation)  <ObjectValidationProtocol>

@property (nonatomic, assign) id<ObjectValidationDelegate> validationDelegate;

- (BOOL) preValidateForInsert:(NSArray**)errorStrings;
- (BOOL) preValidateForUpdate:(NSArray**)errorStrings;
- (BOOL) preValidateForDelete:(NSArray**)errorStrings;

@end
