//
//  ValidationRule.m
//  bzValidation
//
//  Created by Joseph DeCarlo on 8/19/11.
//  Copyright 2011 Baked Ziti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidationRule.h"

@interface ValidationRule()



@end

@implementation ValidationRule

@synthesize validationControl;

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization and Deallocation

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    
    self.validationControl = nil;
    [super dealloc];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - ValidationRuleProtocol


- (BOOL) validateWithMessages:(NSArray **)errorMessages {
    
    [NSException raise:@"Not Implemented" format:@"validate must be implemented in derived class."];
    
    return NO;
}

- (id) getObjectValueToValidate {
    
    if ([self.validationControl class] == [UITextField class]) {
        
        UITextField *control = (UITextField*)self.validationControl;
        
        return [control text];
        
    } else if ([self.validationControl class] == [UITextView class]) {
        
        UITextView *control = (UITextView*)self.validationControl;
        
        return [control text];
    }
    
    [NSException raise:@"Not implemented" format:@"getControlValue cannot determine which control should be validated. Try overriding the method."];
    
    return nil;
}

@end
