//
//  StringLengthRule.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "StringLengthRule.h"

@interface StringLengthRule()



@end

@implementation StringLengthRule

@synthesize minLength, maxLength;
@synthesize targetObject;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation


- (void)dealloc {
    
    self.minLength = nil;
    self.maxLength = nil;
    
    [super dealloc];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - ValidationRuleProtocol

- (BOOL) validateWithMessages:(NSArray **)errorMessages {
    
    BOOL valid = YES;
    
    BOOL conformsToProtocol = [self.targetObject conformsToProtocol:@protocol(ObjectValidationProtocol)];

    NSAssert(conformsToProtocol, @"Cannot validate for target object because it does not conform to the ObjectValidationProtocol");
    
    if (conformsToProtocol) {

        id<ObjectValidationProtocol> ovp = (id<ObjectValidationProtocol>)self.targetObject;
        
        for (ValidationValue *valVaue in [ovp validationValues]) {
            
            NSString *textValue = valVaue.fieldValue;
    
            if (valid && self.minLength) {
                
                valid = ([textValue length] >= [self.minLength intValue]);
            }
            
            if (valid && self.maxLength) {
                
                valid = ([textValue length] <= [self.maxLength intValue]);
            }
            
        }
    }
    
    return valid;
}


@end
