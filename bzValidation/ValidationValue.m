//
//  ValidationValue.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/28/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import "ValidationValue.h"


@implementation ValidationValue

@synthesize fieldName = _fieldName;
@synthesize fieldValue;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation

- (void)dealloc {
    
    self.fieldValue = nil;
    self.fieldName = nil;
    
    [super dealloc];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Methods

+ (ValidationValue*) validationValue:(id)value andFieldName:(NSString *)name {
    
    ValidationValue *validationValue = [[ValidationValue alloc]init];
    
    validationValue.fieldName = name;
    validationValue.fieldValue = value;
    
    return [validationValue autorelease];
}

@end
