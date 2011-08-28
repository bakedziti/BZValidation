//
//  NSManagedObject+PrettyErrors.h
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/26/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ObjectValidationProtocol.h"


@interface NSManagedObject (Validation)  <ObjectValidationProtocol>

@property (nonatomic, assign) id<ObjectValidationDelegate> validationDelegate;

- (BOOL) insertValidationResultWithErrorStrings:(NSArray**)errorStrings;
- (BOOL) updateValidationResultWithErrorStrings:(NSArray**)errorStrings;
- (BOOL) deleteValidationResultWithErrorStrings:(NSArray**)errorStrings;

@end
