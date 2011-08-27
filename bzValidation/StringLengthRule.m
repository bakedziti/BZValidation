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

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation


- (void)dealloc {
    
    self.minLength = nil;
    self.maxLength = nil;
    
    [super dealloc];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - ValidationRule

- (BOOL) validateWithMessages:(NSArray **)errorMessages {
    
    BOOL valid = YES;
    
    NSString* textValue = (NSString*)[self getObjectValueToValidate];
    
    if (self.minLength) {
        
        valid = ([textValue length] >= [self.minLength intValue]);
    }
    
    if (valid && self.maxLength) {
    
        valid = ([textValue length] <= [self.maxLength intValue]);
    }
    
    return valid;
}


@end
